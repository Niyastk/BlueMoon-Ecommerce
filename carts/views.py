from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import redirect, render
from accounts.models import Account, UserAddress
from carts.models import CartItem, Carts, Order
from store.models import Coupon, Products, UsedCoupon, WishListItem
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import uuid
from datetime import date
import razorpay
from django.core.exceptions import ValidationError

# Create your views here.


def cart(request, total=0, quantity=0, cart_items=None):
    try:
        if request.user.is_authenticated:
            user = Carts.objects.get(user=user_id(request))
            cart_items = CartItem.objects.filter(
                cart=user, is_active=True).order_by('-id')
            for cart_item in cart_items:
                if cart_item.product.product_offer:
                    total += (cart_item.product.product_offer_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity
                else:
                    total += (cart_item.product.sale_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity
            print("count :", cart_items.count())
        else:
            user = Carts.objects.get(cart_id=user_id(request))
            cart_items = CartItem.objects.filter(
                cart=user, is_active=True).order_by('-id')
            for cart_item in cart_items:
                if cart_item.product.product_offer:
                    total += (cart_item.product.product_offer_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity
                else:
                    total += (cart_item.product.sale_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity

    except ObjectDoesNotExist:
        pass
    checkout_identifier = "cart"
    context = {
        'total': total,
        'quantity': quantity,
        'cart_items': cart_items,
        'checkout_identifier': checkout_identifier
    }
    return render(request, 'store/cart.html', context)

# function to generate uuid token if no user logged in


def user_id(request):
    if request.user.is_authenticated:
        user = request.user
        user = Account.objects.get(username=user)
    elif request.session.session_key:
        user = request.session.session_key
    else:
        user = str(uuid.uuid4())
        request.session[user] = True
        print("session", user)
    return user


def add_cart(request):

    product_id = request.GET['product_id']
    if request.GET.get('product_variations') != None:
        product_size = request.GET['product_variations']
        print(product_size)
    if request.user.is_authenticated:
        product = Products.objects.get(id=product_id)
        try:
            cart = Carts.objects.get(user=user_id(request))
        except Carts.DoesNotExist:
            cart = Carts.objects.create(user=user_id(request))
        cart.save()
        try:
            cart_item = CartItem.objects.get(product=product, cart=cart)
            cart_item.quantity += 1
            if request.GET.get('product_variations') != None:
                cart_item.variation = product_size
            cart_item.save()
        except CartItem.DoesNotExist:
            if request.GET.get('product_variations') != None:
                cart_item = CartItem.objects.create(
                    product=product, cart=cart, quantity=1, variation=product_size)
            else:
                cart_item = CartItem.objects.create(
                    product=product, cart=cart, quantity=1)
            cart_item.save()
        # if WishListItem.objects.filter(product=product).exists():
        #     WishListItem.objects.filter(product=product).delete()
        return redirect('cart')
    else:
        product = Products.objects.get(id=product_id)
        try:
            cart = Carts.objects.get(cart_id=user_id(request))
        except Carts.DoesNotExist:
            cart = Carts.objects.create(cart_id=user_id(request))
        cart.save()
        try:
            cart_item = CartItem.objects.get(product=product, cart=cart)
            cart_item.quantity += 1
            cart_item.save()
        except CartItem.DoesNotExist:
            cart_item = CartItem.objects.create(
                product=product, cart=cart, quantity=1)
            cart_item.save()
            print("cart_item saved")
        if WishListItem.objects.filter(product=product).exists():
            WishListItem.objects.filter(product=product).delete()
        return JsonResponse("successful", safe=False)


@csrf_exempt
def cart_increment(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)
    print("stock : ", product.stock)

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        user = request.user
        user_instance = Carts.objects.get(user=user)
        update_quantity = CartItem.objects.get(
            cart=user_instance, product=product)
        if product.stock > update_quantity.quantity:
            update_quantity.quantity += 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
        else:
            messages.alert(request, "product is out of stock",
                           extra_tags="out_stock_error")

    else:
        session_key = request.session.session_key
        session_instance = Carts.objects.get(cart_id=session_key)
        update_quantity = CartItem.objects.get(
            cart=session_instance, product=product)
        if product.stock > update_quantity.quantity:
            update_quantity.quantity += 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
        else:
            messages.info(request, "product is out of stock",
                          extra_tags="out_stock_error")
    # updating prodduct cart subtotal
    sub_total = update_quantity.product.sale_price * update_quantity.quantity
    return JsonResponse({'sub_total': sub_total, 'new_quantity': new_quantity})


@csrf_exempt
def cart_decrement(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        print("authenticated")
        user = request.user
        user_instance = Carts.objects.get(user=user)
        print("user_instance", user_instance)
        update_quantity = CartItem.objects.get(
            cart=user_instance, product=product)
        if update_quantity.quantity >= 2:
            update_quantity.quantity -= 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
            print("updated quantity : ", new_quantity)
    else:
        print("not authenticated")
        session_key = request.session.session_key
        session_instance = Carts.objects.get(cart_id=session_key)
        update_quantity = CartItem.objects.get(
            cart=session_instance, product=product)
        if update_quantity.quantity >= 2:
            update_quantity.quantity -= 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
            print("updated quantity : ", new_quantity)

    # updating prodduct cart subtotal(not necessary bcoz its already done in models.py))
    sub_total = update_quantity.product.sale_price * update_quantity.quantity
    return JsonResponse({'sub_total': sub_total, 'new_quantity': new_quantity})


@csrf_exempt
def input_cart(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)
    cart_input = request.POST['cart_input']

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        user = request.user
        user_instance = Carts.objects.get(user=user)
        update_quantity = CartItem.objects.get(
            cart=user_instance, product=product)
        update_quantity.quantity = cart_input
        update_quantity.save()
    else:
        session_key = request.session.session_key
        session_instance = Carts.objects.get(cart_id=session_key)
        update_quantity = CartItem.objects.get(
            cart=session_instance, product=product)
        if cart_input >= 1:
            update_quantity.quantity = cart_input
            update_quantity.save()
    return JsonResponse("success", safe=False)

# remove product from cart


def removeProduct(request):
    product_id = request.GET['product_id']
    product_instance = Products.objects.get(id=product_id)
    CartItem.objects.filter(product=product_instance).delete()
    return redirect('cart')


def add_address(request):
    if request.method == 'POST':
        user = request.user
        user_instance = Account.objects.get(username=user)
        first_name = request.POST['address_first_name']
        last_name = request.POST['address_last_name']
        country = request.POST['address_country']
        street_address = request.POST['address_street_address']
        apartment = request.POST['address_apartment_name']
        town = request.POST['address_town']
        postcode = request.POST['address_postcode']
        phone_number = request.POST['address_phone_number']
        email = request.POST['address_email']

        address = UserAddress(
            user=user_instance,
            first_name=first_name,
            last_name=last_name,
            country=country,
            street_address=street_address,
            apartment=apartment,
            town=town,
            postcode=postcode,
            phone_number=phone_number,
            email=email,
        )
        address.save()
        return redirect(request.META.get('HTTP_REFERER'))

    else:
        return render(request, 'store/addAddress.html')


def editAddress(request, address_id):
    if request.method == 'POST':
        address = UserAddress.objects.get(id=address_id)
        if request.POST.get('address_first_name') != None:
            first_name = request.POST['address_first_name']
            address.first_name = first_name
            address.save()
        if request.POST.get('address_last_name') != None:
            last_name = request.POST['address_last_name']
            address.last_name = last_name
            address.save()
        if request.POST.get('address_country') != None:
            country = request.POST['address_country']
            address.country = country
            address.save()
        if request.POST.get('address_street_address') != None:
            street_address = request.POST['address_street_address']
            address.street_address = street_address
            address.save()
        if request.POST.get('address_apartment_name') != None:
            apartment = request.POST['address_apartment_name']
            address.apartment = apartment
            address.save()
        if request.POST.get('address_town') != None:
            town = request.POST['address_town']
            address.town = town
            address.save()
        if request.POST.get('address_postcode') != None:
            postcode = request.POST['address_postcode']
            address.postcode = postcode
            address.save()
        if request.POST.get('address_postcode') != None:
            phone_number = request.POST['address_phone_number']
            address.phone_number = phone_number
            address.save()
        if request.POST.get('address_email') != None:
            email = request.POST['address_email']
            address.email = email
            address.save()
        return redirect(request.META.get('HTTP_REFERER'))
    else:
        address = UserAddress.objects.get(id=address_id)
        context = {'address': address}
        return render(request, 'store/editAddress.html', context)


@csrf_exempt
def checkout(request, total=0, quantity=0, cart_items=None, checkout_identifier=0):
    if request.method == 'POST':
        if request.POST.get('total_price') != None:
            total_price = request.POST['total_price']
        if request.POST.get('total_price_updated_input') != None and request.POST.get('total_price_updated_input') != "":
            total_price = request.POST['total_price_updated_input']
            total_price = int(total_price)

        address_id = request.POST['address_id']
        address_data = UserAddress.objects.get(id=address_id)
        if request.POST.get('payment_method') == 'cash_on_delivery':
            payment_method = request.POST['payment_method']
        if request.POST.get('payment_method') == 'wallet_pay':
            payment_method = request.POST['payment_method']
        if request.POST.get('payment_method') == 'paypal':
            payment_method = request.POST['payment_method']
        if request.POST.get('payment_method') == 'razorpay':
            payment_method = request.POST['payment_method']
            razorpay_signature = request.POST['razorpay_signature']
            razorpay_payment_id = request.POST['razorpay_payment_id']
            print("signature :", razorpay_signature)
            print("order id :", razorpay_payment_id)

        order_address = address_data.first_name + ", " + \
            address_data.street_address + "," + address_data.apartment + "," + \
            address_data.town + "," + str(address_data.postcode) + "," + \
            str(address_data.phone_number)

        username = request.user
        user_instance = Account.objects.get(username=username)

        # fetching orders from cart
        if checkout_identifier == "fromCart":
            cart = Carts.objects.get(user=user_instance)
            cart_items = CartItem.objects.filter(
                cart=cart, is_active=True).order_by('-id')
            for cart_item in cart_items:
                if cart_item.product.product_offer:
                    total += (cart_item.product.product_offer_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity
                else:
                    total += (cart_item.product.sale_price *
                              cart_item.quantity)
                    quantity += cart_item.quantity

            order_number = str(uuid.uuid4())  # generating order number

            # if coupon applied
            if request.POST.get('total_price_updated_input') != None and request.POST.get('total_price_updated_input') != "":
                total_price = request.POST['total_price_updated_input']
                total = total_price
                coupon_code = request.POST['coupon_code']
                # saving user and coupon as used
                used_coupon = UsedCoupon.objects.create(
                    user=user_instance, coupon_code=coupon_code)
                used_coupon.save()

            # saving order using for loop
            for cart_item in cart_items:
                product = cart_item.product.id
                product_instance = Products.objects.get(id=product)
                product_quantity = cart_item.quantity
                product_instance.stock -= cart_item.quantity
                product_instance.save()
                if cart_item.product.product_offer:
                    sub_total = cart_item.product.product_offer_price * cart_item.quantity
                else:
                    sub_total = cart_item.product.sale_price * cart_item.quantity
                variation = cart_item.variation
                order = Order.objects.create(
                    user=user_instance, product=product_instance, address=order_address, payment_method=payment_method, total=total, order_number=order_number, quantity=product_quantity, sub_total=sub_total, variation=variation)

            # deducting money from wallet if its wallet money transaction
            if payment_method == "wallet_pay":
                wallet_user_name = request.user
                wallet_user = Account.objects.get(username=wallet_user_name)
                wallet_user.wallet -= total
                wallet_user.save()

            # deleting items from the cart after order placing
            CartItem.objects.filter(
                cart=cart, is_active=True).delete()
        else:  # fetching order from buynow
            product = Products.objects.get(id=checkout_identifier)
            if product.product_offer:
                total = product.product_offer_price
                quantity = 1
            else:
                total = product.sale_price
                quantity = 1
            order_number = str(uuid.uuid4())  # generating order number

            # if coupon applied
            if request.POST.get('total_price_updated_input') != None and request.POST.get('total_price_updated_input') != "":
                total_price = request.POST['total_price_updated_input']
                print("total price", total_price)
                total = total_price
                coupon_code = request.POST['coupon_code']
                # saving user and coupon as used
                used_coupon = UsedCoupon.objects.create(
                    user=user_instance, coupon_code=coupon_code)
                used_coupon.save()

            # quantity decreasing
            product.stock -= 1
            product.save()

            # saving item as order
            order = Order.objects.create(
                user=user_instance, product=product, address=order_address, payment_method=payment_method, total=total, order_number=order_number, quantity=quantity, sub_total=total)

            # deducting money from wallet if its wallet money transaction
            if payment_method == "wallet_pay":
                wallet_user_name = request.user
                wallet_user = Account.objects.get(username=wallet_user_name)
                wallet_user.wallet -= total
                wallet_user.save()

        context = {'order_number': order_number,
                   'quantity': quantity, 'total': total, 'order_address': order_address}
        return render(request, 'store/orderSuccess.html', context)
    else:
        if checkout_identifier == "cart":
            if request.user.is_authenticated:
                user = request.user
                user = Account.objects.get(username=user)
                user = Carts.objects.get(user=user)
                cart_items = CartItem.objects.filter(
                    cart=user, is_active=True).order_by('-id')
                for cart_item in cart_items:
                    if cart_item.product.product_offer:
                        total += (cart_item.product.product_offer_price *
                                  cart_item.quantity)
                        quantity += cart_item.quantity
                    else:
                        total += (cart_item.product.sale_price *
                                  cart_item.quantity)
                        quantity += cart_item.quantity
                # getting address if the user is authenticated
                user_name = request.user
                user_instance = Account.objects.get(username=user_name)
                address = UserAddress.objects.filter(user=user_instance)

                context = {
                    'total': total,
                    'quantity': quantity,
                    'cart_items': cart_items,
                    'address': address,
                    'id': 'fromCart'
                }
                return render(request, 'store/checkout.html', context)
            else:
                return redirect('signUp')
        else:
            product = Products.objects.get(id=checkout_identifier)
            if request.user.is_authenticated:
                if product.product_offer:
                    total = product.product_offer_price
                    quantity = 1
                else:
                    total = product.sale_price
                    quantity = 1
                user_name = request.user
                user_instance = Account.objects.get(username=user_name)
                address = UserAddress.objects.filter(user=user_instance)

                context = {
                    'total': total,
                    'quantity': quantity,
                    'product': product,
                    'address': address,
                    'id': product.id
                }
                return render(request, 'store/checkout.html', context)
            else:
                return redirect('signUp')


def couponApply(request):
    if request.GET.get('coupon_code') != None:
        coupon_code = request.GET['coupon_code']
        try:
            if Coupon.objects.filter(coupon_code=coupon_code).exists():
                # checking weather coupon used or not
                username = request.user
                user = Account.objects.get(username=username)
                if UsedCoupon.objects.filter(user=user, coupon_code=coupon_code).exists():
                    return JsonResponse("coupon already used ", safe=False)
                else:
                    coupon_code = Coupon.objects.get(coupon_code=coupon_code)
                    minimum_rate = coupon_code.minimum_rate
                    coupon_percentage = coupon_code.percentage
                    return JsonResponse({'minimum_rate': minimum_rate, 'coupon_percentage': coupon_percentage})
        except ValidationError:
            return JsonResponse("coupon not valid", safe=False)


def orderCancel(request):
    order_number = request.GET['order_number']
    order = Order.objects.filter(
        order_number=order_number).update(order_status='Order Canceled')
    return JsonResponse("successful", safe=False)


def orderReturn(request):
    order_number = request.GET['order_number']
    order = Order.objects.filter(
        order_number=order_number).update(order_status='Order Returned')
    return JsonResponse("successful", safe=False)


def deleteAddress(request):
    address_id = request.GET['address_id']
    UserAddress.objects.filter(id=address_id).delete()
    return redirect(request.META.get('HTTP_REFERER'))


def razorpayPayment(request, product_id=0):
    print("product id", product_id)
    total = 0
    if product_id == "fromCart":
        username = request.user
        user_instance = Account.objects.get(username=username)
        cart = Carts.objects.get(user=user_instance)
        cart_items = CartItem.objects.filter(
            cart=cart, is_active=True).order_by('-id')
        for cart_item in cart_items:
            if cart_item.product.product_offer:
                total += (cart_item.product.product_offer_price *
                          cart_item.quantity)
            else:
                total += (cart_item.product.sale_price *
                          cart_item.quantity)
    else:
        product = Products.objects.get(id=product_id)
        if product.product_offer:
            total = product.product_offer_price
        else:
            total = product.sale_price
    if request.GET.get('total_price_updated_input') != None and request.GET.get('total_price_updated_input') != "":
        total = int(request.GET['total_price_updated_input'])

    order_number = str(uuid.uuid4())  # generating order number
    total = total * 100
    client = razorpay.Client(
        auth=("rzp_test_CyPI9bn2wBijjw", "zh7jniju168UPTgxBWCdUD5p"))
    data = {"amount": total, "currency": "INR", "receipt": order_number}

    payment = client.order.create(data=data)
    context = {'payment': payment, 'total': total}

    return JsonResponse(context)
