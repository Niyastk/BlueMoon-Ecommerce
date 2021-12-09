
from django.core.exceptions import ObjectDoesNotExist
from accounts.models import Account
from adminBluemoon.models import Offer
from carts.models import CartItem, Carts
from carts.views import user_id
from category.models import Category, SubCategory
import datetime

from store.models import Coupon


def cart_counter(request):
    try:

        # car counter function starting
        if request.user.is_authenticated:
            user = request.user
            user_instance = Account.objects.get(username=user)
            cart = Carts.objects.get(user=user_instance)
            cart_items = CartItem.objects.filter(cart=cart)
            cart_count = cart_items.count()
            return dict(cart_count=cart_count)
        else:
            try:
                user = Carts.objects.get(cart_id=user_id(request))
                cart_items = CartItem.objects.filter(
                    cart=user)
                cart_count = cart_items.count()
                return dict(cart_count=cart_count)
            except ObjectDoesNotExist:
                cart_count = 0
            return dict(cart_count=cart_count)
    except ObjectDoesNotExist:
        return {}


def ParentCategories(request):
    parent_categories = Category.objects.all()
    return dict(parent_categories=parent_categories)


def SubCategories(request):
    sub_categories = SubCategory.objects.all()
    return dict(sub_categories=sub_categories)


def Expiries(request):
    # deleteing expired offers
    today_date = datetime.date.today()
    now_time = datetime.datetime.now().strftime('%H:%M')
    Offer.objects.filter(
        expiry_date__lte=today_date, expiry_time__lte=now_time).delete()

    # deleting expired coupon
    today_date = datetime.date.today()
    now_time = datetime.datetime.now().strftime('%H:%M')
    Coupon.objects.filter(expiry_date__lte=today_date,
                          expiry_time__lte=now_time).delete()
    return {}
