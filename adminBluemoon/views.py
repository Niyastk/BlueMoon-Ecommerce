
import datetime
import uuid
from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from django.contrib.auth.models import auth
from django.contrib import messages
from django.views.decorators.cache import cache_control, never_cache
from isoweek import Week
from accounts.models import Account
from adminBluemoon.models import Offer
from carts.models import Order
from store.models import Banner, Coupon, Products

# Create your views here.


@never_cache
def adminLogin(request):
    if request.session.has_key('admin_login'):
        return redirect('adminPanel')
    else:
        if request.method == 'POST':
            username = request.POST['admin_username']
            password = request.POST['admin_password']
            user = auth.authenticate(username=username, password=password)
            if user is not None and user. is_superadmin:
                auth.login(request, user)
                # session created
                request.session['admin_login'] = True
                return redirect('adminPanel')
            else:
                messages.info(request, 'Invalid Credentials ',
                              extra_tags="admin_invalid_login")
                return render(request, 'admin/adminLogin.html')
        else:
            return render(request, 'admin/adminLogin.html')


def adminPanel(request):
    total_cash_on_delivery = 0
    total_paypal = 0
    total_razorpay = 0
    orders = Order.objects.all().distinct('order_number')
    for order in orders:
        if order.payment_method == "cash_on_delivery":
            total_cash_on_delivery += order.total
        if order.payment_method == "paypal":
            total_paypal += order.total
        if order.payment_method == "razorpay":
            total_razorpay += order.total
    customers = Account.objects.all()
    customers_count = len(customers)
    order_count = len(orders)
    average_sale = round((total_cash_on_delivery + total_paypal +
                          total_razorpay) / order_count)
    products = Products.objects.all()
    product_count = len(products)
    average_item_sale = order_count / product_count
    total_sale = total_cash_on_delivery + total_paypal + total_razorpay

    context = {'total_cash_on_delivery': total_cash_on_delivery,
               'total_paypal': total_paypal,
               'total_razorpay': total_razorpay,
               'customers_count': customers_count,
               'order_count': order_count,
               'average_sale': average_sale,
               'average_item_sale': average_item_sale,
               'product_count': product_count,
               'total_sale': total_sale,
               'products': products,
               'orders': orders
               }
    return render(request, 'admin/adminPanel.html', context)


def customerList(request):
    data = Account.objects.all().order_by('id')
    return render(request, 'admin/customerList.html', {'data': data})


def activeStatus(request, status_id):
    user = Account.objects.get(id=status_id)
    if user.is_active:
        user.is_active = False
        user.save()
        return redirect(customerList)
    else:
        user.is_active = True
        user.save()
        return redirect(customerList)


def orderList(request):
    order_details = Order.objects.distinct('order_number')
    context = {'order_details': order_details}
    return render(request, 'admin/orderList.html', context)


def orderDetails(request, order_number):
    order_details = Order.objects.filter(order_number=order_number)
    date = Order.objects.filter(order_number=order_number).distinct('date')

    context = {
        'order_details': order_details,
        'date': date,
    }
    return render(request, 'admin/orderDetails.html', context)


def AdminOrderStatus(request, order_number):
    print("reached on orderstatus")
    if request.POST.get('order_status') == "order_placed":
        print("orderplaced")
        Order.objects.filter(order_number=order_number).update(
            order_status="Order Placed")

    if request.POST.get('order_status') == "order_shipped":
        Order.objects.filter(order_number=order_number).update(
            order_status="Order Shipped")

    if request.POST.get('order_status') == "order_completed":
        Order.objects.filter(order_number=order_number).update(
            order_status="Order Completed")

    if request.POST.get('order_status') == "order_cancel":
        Order.objects.filter(order_number=order_number).update(
            order_status="Order Canceled")

    if request.POST.get('order_status') == "order_return":
        Order.objects.filter(order_number=order_number).update(
            order_status="Order Returned")

    return redirect(request.META.get('HTTP_REFERER'))


def offerAdd(request):
    if request.method == 'POST':
        offer_name = request.POST['offer_name']
        percentage = request.POST['offer_percentage']
        expiry_date = request.POST['expiry_date']
        expiry_time = request.POST['expiry_time']
        offer = Offer(offer_name=offer_name, percentage=percentage,
                      expiry_date=expiry_date, expiry_time=expiry_time)
        offer.save()
        offers = Offer.objects.all()
        context = {'offers': offers}
        return render(request, 'admin/offerAdd.html', context)
    else:
        offers = Offer.objects.all()
        context = {'offers': offers}
        return render(request, 'admin/offerAdd.html', context)


def offerEdit(request, offer_id):
    if request.method == 'POST':
        offer = Offer.objects.get(id=offer_id)
        if request.POST.get('offer_name') != None and request.POST.get('offer_name') != "":
            offer_name = request.POST['offer_name']
            offer.offer_name = offer_name
        if request.POST.get('offer_percentage') != None and request.POST.get('offer_percentage') != "":
            offer_percentage = request.POST['offer_percentage']
            offer.percentage = offer_percentage
        if request.POST.get('expiry_date') != None and request.POST.get('expiry_date') != "":
            expiry_date = request.POST['expiry_date']
            offer.expiry_date = expiry_date
        if request.POST.get('expiry_time') != None and request.POST.get('expiry_time') != "":
            expiry_time = request.POST['expiry_time']
            offer.expiry_time = expiry_time
        offer.save()
        return redirect('offerAdd')
    else:
        offer = Offer.objects.get(id=offer_id)
        context = {'offer': offer}
        return render(request, 'admin/offerEdit.html', context)


def offerDelete(request, offer_id):
    Offer.objects.filter(id=offer_id).delete()
    return redirect('offerAdd')


def dailySales(request):
    if request.method == 'POST':
        date_from = request.POST['date_from']
        date_to = request.POST['date_to']
        orders = Order.objects.filter(
            date__range=[date_from, date_to])
        context = {'orders': orders,
                   'date_from': date_from,
                   'date_to': date_to}
        return render(request, 'admin/dailySales.html', context)
    else:
        orders = Order.objects.all()
        context = {'orders': orders}
        return render(request, 'admin/dailySales.html', context)


def weeklySales(request):
    if request.method == 'POST':
        date_from = request.POST['date_from']
        year = int(date_from[:4])
        week = int(date_from[-2:])
        date_from = Week(year, week).monday()
        date_to = request.POST['date_to']
        year = int(date_to[:4])
        week = int(date_to[-2:])
        date_to = Week(year, week).monday()
        orders = Order.objects.filter(
            date__range=[date_from, date_to])
        context = {'orders': orders}
        return render(request, 'admin/weeklySales.html', context)
    else:
        orders = Order.objects.all()
        context = {'orders': orders}
        return render(request, 'admin/weeklySales.html', context)


def yearlySales(request):
    if request.method == 'POST':
        date_from = request.POST['date_from']
        date_to = request.POST['date_to']
        date_from = date_from + '-01-' + '01'
        date_to = date_to + '-12-' + '31'
        orders = Order.objects.filter(
            date__range=[date_from, date_to])
        context = {'orders': orders}
        return render(request, 'admin/yearlySales.html', context)
    else:
        orders = Order.objects.all()
        context = {'orders': orders}
        return render(request, 'admin/yearlySales.html', context)


# def export_csv(request):
#     date_from = request.GET['date_from_csv']
#     date_to = request.GET['date_to_csv']
#     print("from and two :", date_from, date_to)
#     response = HttpResponse(content_type='text/csv')
#     response['Content-Disposition'] = 'attachment; filename= DailyReport' + \
#         str(datetime.datetime.now()) + ".csv"
#     writer = csv.writer(response)
#     writer.writerow(
#         ['Order Number', 'Name', 'Product Details', 'Quantity', 'Total', 'Payment Method', 'Status', 'Date'])

#     daily_reports = Order.objects.filter(date__range=[date_from, date_to])
#     for report in daily_reports:
#         writer.writerow([report.order_number, report.user.username,
#                         report.product.product_name, report.quantity, report.total, report.payment_method, report.order_status, report.date])
#     return response


def couponList(request):
    if request.method == 'POST':
        purchase_rate = request.POST['purchase_rate']
        coupon_percentage = request.POST['coupon_percentage']
        expiry_date = request.POST['expiry_date']
        expiry_time = request.POST['expiry_time']
        coupon = Coupon.objects.create(
            minimum_rate=purchase_rate, percentage=coupon_percentage, coupon_code=uuid.uuid4(), expiry_date=expiry_date, expiry_time=expiry_time)
        coupon.save()
        return redirect(couponList)
    else:
        coupons = Coupon.objects.all().order_by('-expiry_date')
        context = {'coupons': coupons}
        return render(request, 'admin/couponList.html', context)


def couponEdit(request, coupon_id):
    coupon = Coupon.objects.get(id=coupon_id)
    if request.method == 'POST':
        if request.POST.get('purchase_rate') != None and request.POST.get('purchase_rate') != "":
            purchase_rate = request.POST['purchase_rate']
            coupon.minimum_rate = purchase_rate
        if request.POST.get('coupon_percentage') != None and request.POST.get('coupon_percentage') != "":
            coupon_percentage = request.POST['coupon_percentage']
            coupon.percentage = coupon_percentage
        if request.POST.get('expiry_date') != None and request.POST.get('expiry_date') != "":
            expiry_date = request.POST['expiry_date']
            coupon.expiry_date = expiry_date
        if request.POST.get('expiry_time') != None and request.POST.get('expiry_time') != "":
            expiry_time = request.POST['expiry_time']
            coupon.expiry_time = expiry_time
        coupon.save()
        return redirect('couponList')
    else:

        context = {'coupon': coupon}
        return render(request, 'admin/couponEdit.html', context)


def couponDelete(request, coupon_id):
    Coupon.objects.get(id=coupon_id).delete()
    return redirect('couponList')


def bannerEdit(request):
    if request.method == 'POST':
        banner = Banner.objects.get(id=1)
        if request.POST.get('banner_tagline') != None:
            banner_tagline = request.POST['banner_tagline']
            banner.tag_line = banner_tagline
        if request.POST.get('banner_heading') != None:
            banner_heading = request.POST['banner_heading']
            banner.heading = banner_heading
        if request.POST.get('banner_percentage') != None:
            banner_percentage = request.POST['banner_percentage']
            banner.offer_percentage = banner_percentage
        if request.POST.get('starting_price') != None:
            starting_price = request.POST['starting_price']
            banner.starting_price = starting_price
        if request.POST.get('button_url') != None:
            button_url = request.POST['button_url']
            banner.button_url = button_url
        if request.FILES.get('banner_image') != None:
            banner_image = request.FILES['banner_image']
            banner.banner_image = banner_image
        banner.save()
        return redirect(bannerEdit)
    else:
        banner_details = Banner.objects.get(id=1)
        return render(request, 'admin/bannerEdit.html', {"banner_details": banner_details})


def OrderCancelReport(request):
    if request.method == 'POST':
        date_from = request.POST['date_from']
        date_to = request.POST['date_to']
        orders = Order.objects.filter(
            date__range=[date_from, date_to], order_status="Order Canceled")
        context = {'orders': orders}
        for order in orders:
            print("order: ", order.id)
        return render(request, 'admin/OrderCancelReport.html', context)
    else:
        orders = Order.objects.filter(order_status="Order Canceled")
        context = {'orders': orders}
        return render(request, 'admin/OrderCancelReport.html', context)


def adminLogout(request):
    del request.session['admin_login']
    auth.logout(request)
    return redirect(adminLogin)
