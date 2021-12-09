import uuid
from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import redirect, render
from Ecommerce.views import home
from django.contrib.auth.models import auth
from accounts.forms import RegistrationForm
from accounts.models import Account, UserAddress
from django.contrib import messages
from django.views.decorators.cache import cache_control

# OTP auth
import random
from twilio.rest import Client
from .private import account_sid, auth_token, service

from carts.models import CartItem, Carts, Order
from carts.views import user_id


# Create your views here.


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def signUp(request):
    if request.session.has_key('user_login'):
        return redirect(home)
    else:
        if request.method == 'POST':
            form = RegistrationForm(request.POST)
            print(form.data['referral_code'])
            if form.is_valid():
                first_name = form.cleaned_data['first_name']
                last_name = form.cleaned_data['last_name']
                username = form.cleaned_data['username']
                email = form.cleaned_data['email']
                phone_number = form.cleaned_data['phone_number']
                # address = form.cleaned_data['address']
                password = form.cleaned_data['password']
                referral_code = form.cleaned_data['referral_code']
                wallet = 0
                if referral_code != "" and referral_code != None:
                    if Account.objects.filter(referral_code=referral_code).exists():
                        wallet = 10
                        referred_user = Account.objects.get(
                            referral_code=referral_code)
                        referred_user.wallet += 10
                        referred_user.save()
                    else:
                        messages.info(request, 'Invalid referral code',
                                      extra_tags="referral_error")
                        form = RegistrationForm()
                        context = {
                            'form': form, }
                        return render(request, 'accounts/login.html', context)

                if Account.objects.filter(email=email).exists():
                    messages.info(request, 'Email is taken',
                                  extra_tags="email_error")
                    print("email exist")
                    form = RegistrationForm()
                    context = {
                        'form': form, }
                    return render(request, 'accounts/login.html', context)
                else:
                    # genarating sliced uuid referral code
                    code = uuid.uuid4()
                    code = str(code)
                    code = code[:8]
                    referral_code = code

                    # saving user
                    user = Account.objects.create_user(
                        first_name=first_name, last_name=last_name, username=username, email=email, password=password, phone_number=phone_number)
                    user.referral_code = referral_code
                    if wallet != 0:
                        user.wallet = wallet
                    # user.address = address
                    user.save()
                    print("User saved")
                    # session created
                    auth.login(request, user)
                    request.session['user_login'] = True
                    return redirect(home)
            else:
                form = RegistrationForm(request.POST)
                username = form.data['username']
                print("form invalid")
                if Account.objects.filter(username=username).exists():
                    messages.info(request, 'Username is taken',
                                  extra_tags="username_error")
                    print("user exist")
                    form = RegistrationForm()
                    context = {
                        'form': form, }
                    return render(request, 'accounts/login.html', context)
                else:
                    form = RegistrationForm()
                    context = {
                        'form': form, }
                    return render(request, 'accounts/login.html', context)
        else:
            form = RegistrationForm()
            context = {
                'form': form, }
            return render(request, 'accounts/login.html', context)


def signIn(request):
    if request.method == 'POST':
        username = request.POST['login_username']
        password = request.POST['login_password']
        user = auth.authenticate(
            username=username, password=password)
        if user is not None:
            auth.login(request, user)
            try:
                # getting nonlogged user cart items
                user_username = request.user
                print("username : ", user_username)
                user_instance = Account.objects.get(username=user_username)
                if request.COOKIES['sessionid']:
                    old_cart = request.COOKIES['sessionid']
                    user = Carts.objects.get(cart_id=old_cart)
                    cart_items = CartItem.objects.filter(
                        cart=user, is_active=True).order_by('-id')
                    for cart_item in cart_items:
                        print(cart_item.product.product_name)
                    # getting/creating newly logged users cart
                    try:
                        cart = Carts.objects.get(user=user_instance)
                    except Carts.DoesNotExist:
                        cart = Carts.objects.create(user=user_instance)
                        cart.save()
                    # saving old cart items to newly logged user cart
                    for cart_item in cart_items:
                        try:
                            item = CartItem.objects.get(
                                product=cart_item.product, cart=cart)
                            item.quantity += cart_item.quantity
                            item.save()
                        except CartItem.DoesNotExist:
                            item = CartItem.objects.create(
                                product=cart_item.product, cart=cart, quantity=cart_item.quantity)
                            item.save()
            except ObjectDoesNotExist:
                pass
            # session created
            request.session['user_login'] = True
            return redirect(home)
        else:
            messages.info(request, 'Incorrect username or password',
                          extra_tags="login_error")
            return redirect(signUp)


def otpLogin(request):
    # global random_otp, verified_user
    if request.session.has_key('user_login'):
        return redirect(home)
    else:
        if request.method == 'POST':
            phone_number = request.POST['otp_phone_number']
            if Account.objects.filter(phone_number=phone_number).exists():
                phone_number = '+91'+str(phone_number)
                client = Client(account_sid, auth_token)

                verification = client.verify \
                    .services(service) \
                    .verifications \
                    .create(to=phone_number, channel='sms')
                return render(request, 'accounts/submitOtp.html', {'phone_number': phone_number})
            else:
                messages.info(request, 'The phone number does not exist',
                              extra_tags="phone_number_otp_error")
                return render(request, 'accounts/otpLogin.html')
        else:
            return render(request, 'accounts/otpLogin.html')


def submitOtp(request, phone_number):
    if request.session.has_key('user_login'):
        return redirect(home)
    else:
        if request.POST.get('otp') != None:
            user_phone_number = int(phone_number[3:])
            verified_user = Account.objects.get(phone_number=user_phone_number)
            otp_user = request.POST['otp']
            client = Client(account_sid, auth_token)
            verification_check = client.verify \
                .services(service) \
                .verification_checks \
                .create(to=phone_number, code=otp_user)
            if verification_check.status == "approved":
                request.session['user_login'] = True
                auth.login(request, verified_user)
                return redirect(home)
            else:
                messages.info(request, 'Invalid Otp',
                              extra_tags="invalid_otp")
                return render(request, 'accounts/submitOtp.html', {'phone_number': phone_number})
        else:
            return render(request, 'accounts/submitOtp.html', {'phone_number': phone_number})


def userDashboard(request):
    # user orders
    user = request.user
    user_instance = Account.objects.get(username=user)
    orders = Order.objects.filter(user=user_instance).distinct('order_number')

    # user address
    address = UserAddress.objects.filter(user=user_instance)

    context = {'orders': orders, 'address': address}
    return render(request, 'userDashboard.html', context)


def userDetailsEdit(request):
    user = request.user
    user_instance = Account.objects.get(username=user)
    if request.POST.get('acc-name') != None:
        first_name = request.POST['acc-name']
        user_instance.first_name = first_name
    if request.POST.get('acc-lastname') != None:
        last_name = request.POST['acc-lastname']
        user_instance.last_name = last_name
    if request.POST.get('acc-email') != None and request.POST.get('acc-email') != "":
        email = request.POST['acc-email']
        if Account.objects.filter(email=email).exists():
            messages.info(request, "Email is Taken", extra_tags="email_taken")
            return redirect(request.META.get('HTTP_REFERER'))
        else:
            user_instance.email = email
    if request.POST.get('acc-phone') != None and request.POST.get('acc-phone') != "":
        phone_number = request.POST['acc-phone']
        if Account.objects.filter(phone_number=phone_number).exists():
            messages.info(request, "Phone Number already registered",
                          extra_tags="phone_number_taken")
            return redirect(request.META.get('HTTP_REFERER'))
        else:
            user_instance.phone_number = phone_number
    user_instance.save()
    return redirect(request.META.get('HTTP_REFERER'))


def userPasswordChange(request):
    user = request.user
    user_instance = Account.objects.get(username=user)
    current_password = request.POST['current_password']
    new_password = request.POST['acc-new-password']
    new_repassword = request.POST['acc-confirm-password']
    if new_password == new_repassword and new_password != "" and new_repassword != "":
        valid_user = auth.authenticate(
            request, username=user, password=current_password)
        if valid_user is not None:
            user_instance.set_password(new_password)
            user_instance.save()
            return redirect(signUp)
        else:
            messages.info(request, "Incorrect Password",
                          extra_tags="incorrect_password")
            return redirect(request.META.get('HTTP_REFERER'))
    else:
        messages.info(request, "The passwords Doesn't match",
                      extra_tags="password_match")
        return redirect(request.META.get('HTTP_REFERER'))


def userOrderDetails(request, order_number):
    orders = Order.objects.filter(order_number=order_number)
    context = {'orders': orders}
    return render(request, 'userOrderDetails.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def signOut(request):
    if request.session.has_key('admin_login'):
        del request.session['admin_login']
        auth.logout(request)
        return redirect(signUp)
    else:
        del request.session['user_login']
        auth.logout(request)
        return redirect(signUp)
