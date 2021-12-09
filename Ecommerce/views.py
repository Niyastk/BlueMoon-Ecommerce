import uuid
from django.shortcuts import render
# from accounts.models import Account
# from carts.models import CartItem, Carts

from store.models import Banner, Products


def home(request):
    banner_details = Banner.objects.get(id=1)
    products_data = Products.objects.all()
    products_data_reversed = Products.objects.all().order_by('id')
    return render(request, 'home.html', {'products_data': products_data, 'banner_details': banner_details, 'products_data_reversed': products_data_reversed})
