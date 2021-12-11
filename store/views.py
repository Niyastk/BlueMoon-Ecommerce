from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.core.files.base import ContentFile
import base64
from django.http.response import HttpResponse, HttpResponseRedirect, JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.csrf import csrf_exempt
from carts.views import user_id
from category.models import Category, SubCategory
from store.models import ProductImages, Products, WishListItem, Wishlist
from django.db import IntegrityError
from django.contrib.auth.decorators import login_required
from adminBluemoon.models import Offer
from django.db.models import Q
import csv
import datetime
# Create your views here.


@login_required(login_url='adminLogin')
def productAdd(request):
    if request.method == 'POST':
        product = Products()
        # checking for nulls
        if request.POST.get('product_name') != None:
            product_name = request.POST['product_name']
            slug = product_name.replace(" ", "-")
            product.product_name = product_name
            product.slug = slug
        if request.POST.get('product_mrp') != None and request.POST.get('product_mrp') != "":
            product_mrp = request.POST['product_mrp']
            product.mrp = product_mrp
        if request.POST.get('product_sale_price') != None and request.POST.get('product_sale_price') != "":
            product_sale_price = request.POST['product_sale_price']
            product.sale_price = product_sale_price
        if request.POST.get('product_stock') != None and request.POST.get('product_stock') != "":
            product_stock = request.POST['product_stock']
            product.stock = product_stock
        if request.POST.get('product_description') != None:
            product_description = request.POST['product_description']
            product.description = product_description
        if request.POST.get('product_size_S') != None:
            product.size_s = True
        if request.POST.get('product_size_M') != None:
            product.size_m = True
        if request.POST.get('product_size_L') != None:
            product.size_l = True
        if request.POST.get('product_size_XL') != None:
            product.size_xl = True
        # foreign key category
        if request.POST.get('product_category_id') != None:
            product_category_id = request.POST['product_category_id']
            product_instance = SubCategory.objects.get(
                id=product_category_id)
            product.category = product_instance
        # product image
        if request.POST.get('product_image') != None and request.POST.get('product_image') != "":
            product_image_base64 = request.POST['product_image']
            format, img1 = product_image_base64.split(';base64,')
            ext = format.split('/')[-1]
            product_image_cropped = ContentFile(base64.b64decode(
                img1), name=product_name + '1.' + ext)
            product.image = product_image_cropped
        try:
            product.save()
        except IntegrityError:
            pass

        if Products.objects.filter(slug=slug).exists():
            # getting gallery images
            image_instance = Products.objects.get(slug=slug)

            if request.POST.get('product_gallery1') != None and request.POST.get('product_gallery1') != "":
                product_gallery_image1 = request.POST['product_gallery1']
                format, img2 = product_gallery_image1.split(';base64,')
                ext2 = format.split('/')[-1]
                galley_image_cropped1 = ContentFile(base64.b64decode(
                    img2), name=product_name + '2.' + ext2)
                product_gallery_image = ProductImages.objects.create(
                    product=image_instance, image=galley_image_cropped1)

            if request.POST.get('product_gallery2') != None and request.POST.get('product_gallery2') != "":
                product_gallery_image2 = request.POST['product_gallery2']
                format, img3 = product_gallery_image2.split(';base64,')
                ext3 = format.split('/')[-1]
                galley_image_cropped2 = ContentFile(base64.b64decode(
                    img3), name=product_name + '3.' + ext3)
                product_gallery_image = ProductImages.objects.create(
                    product=image_instance, image=galley_image_cropped2)

            if request.POST.get('product_gallery3') != None and request.POST.get('product_gallery3') != "":
                product_gallery_image3 = request.POST['product_gallery3']
                format, img4 = product_gallery_image3.split(';base64,')
                ext4 = format.split('/')[-1]
                galley_image_cropped3 = ContentFile(base64.b64decode(
                    img4), name=product_name + '4.' + ext4)
                product_gallery_image = ProductImages.objects.create(
                    product=image_instance, image=galley_image_cropped3)

            if request.POST.get('product_gallery4') != None and request.POST.get('product_gallery4') != "":
                product_gallery_image4 = request.POST['product_gallery4']
                format, img5 = product_gallery_image4.split(';base64,')
                ext5 = format.split('/')[-1]
                galley_image_cropped4 = ContentFile(base64.b64decode(
                    img5), name=product_name + '5.' + ext5)
                product_gallery_image = ProductImages.objects.create(
                    product=image_instance, image=galley_image_cropped4)
            return redirect(productList)
        else:
            return redirect(request.META.get('HTTP_REFERER', productList))
    else:
        sub_category_data = SubCategory.objects.all()
        return render(request, 'products/productAdd.html', {'sub_category_data': sub_category_data})


# def galleryEditAdd(request, product_id):
#     image_instance = Products.objects.get(id=product_id)
#     if request.FILES.get('product_gallery1') != None and request.FILES.get('product_gallery1') != "":
#         product_gallery1 = request.FILES['product_gallery1']
#         gallery_image = ProductImages.objects.create(
#             product=image_instance, image=product_gallery1)
#     if request.FILES.get('product_gallery2') != None and request.FILES.get('product_gallery2') != "":
#         product_gallery2 = request.FILES['product_gallery2']
#         gallery_image = ProductImages.objects.create(
#             product=image_instance, image=product_gallery2)
#     if request.FILES.get('product_gallery3') != None and request.FILES.get('product_gallery3') != "":
#         product_gallery3 = request.FILES['product_gallery3']
#         gallery_image = ProductImages.objects.create(
#             product=image_instance, image=product_gallery3)
#     if request.FILES.get('product_gallery4') != None and request.FILES.get('product_gallery4') != "":
#         product_gallery4 = request.FILES['product_gallery4']
#         gallery_image = ProductImages.objects.create(
#             product=image_instance, image=product_gallery4)
#     # images = request.FILES.get('product_gallery')
#     # for image in images:
#     #     gallery_image = ProductImages(product=image_instance, image=image,)
#     #     gallery_image.save()
#     return redirect(request.META.get('HTTP_REFERER', productList))

@login_required(login_url='adminLogin')
def productList(request):
    product_data = Products.objects.all()
    return render(request, 'products/productList.html', {'product_data': product_data})


@login_required(login_url='adminLogin')
def productEdit(request, product_id):
    if request.method == 'POST':
        product = Products.objects.get(id=product_id)
        if request.POST.get('product_name') != None and request.POST.get('product_name') != "":
            product_name = request.POST['product_name']
            slug = product_name.replace(" ", "-")
            product.product_name = product_name
            product.slug = slug
        if request.POST.get('product_mrp') != None and request.POST.get('product_mrp') != "":
            product_mrp = request.POST['product_mrp']
            product.mrp = product_mrp
        if request.POST.get('product_sale_price') != None and request.POST.get('product_sale_price') != "":
            product_sale_price = request.POST['product_sale_price']
            product.sale_price = product_sale_price
        if request.POST.get('product_stock') != None and request.POST.get('product_stock') != "":
            product_stock = request.POST['product_stock']
            product.stock = product_stock
        if request.POST.get('product_description') != None and request.POST.get('product_description') != "":
            product_description = request.POST['product_description']
            product.description = product_description

        if request.POST.get('product_size_S') != None:
            product.size_s = True
        if request.POST.get('product_size_M') != None:
            product.size_m = True
        if request.POST.get('product_size_L') != None:
            product.size_l = True
        if request.POST.get('product_size_XL') != None:
            product.size_xl = True

        if request.POST.get('product_category_id') != None and request.POST.get('product_category_id') != "":
            product_category_id = request.POST['product_category_id']
            product_instance = SubCategory.objects.get(id=product_category_id)
            product.category = product_instance

        if product.category.subcategory_offer != "" and product.category.subcategory_offer != None:
            subcategory_offer = product.category.subcategory_offer
            product.product_offer = subcategory_offer
            category_offer_peracentage = product.category.subcategory_offer.percentage
            product_saleprice = float(product.sale_price)
            product_offer_price = product_saleprice - \
                product_saleprice*category_offer_peracentage/100
            product.product_offer_price = product_offer_price
            product.offer_type = "category_offer"

        if request.POST.get('offer_id') != None and request.POST.get('offer_id') != "":
            product_category_offer = request.POST['offer_id']
            if product_category_offer != "None":
                offer_instance = Offer.objects.get(id=product_category_offer)
                product.product_offer = offer_instance
                if product.category.subcategory_offer != "" and product.category.subcategory_offer != None:
                    category_offer_peracentage = product.category.subcategory_offer.percentage
                    product_offer_peracentage = product.product_offer.percentage
                    if category_offer_peracentage < product_offer_peracentage:
                        product_saleprice = float(product.sale_price)
                        product_offer_price = product_saleprice - \
                            product_saleprice*product_offer_peracentage/100
                        product.product_offer_price = product_offer_price
                        product.offer_type = "product_offer"
                    else:
                        subcategory_offer = product.category.subcategory_offer
                        product.product_offer = subcategory_offer
                        product_saleprice = float(product.sale_price)
                        product_offer_price = product_saleprice - \
                            product_saleprice*category_offer_peracentage/100
                        product.product_offer_price = product_offer_price
                        product.offer_type = "category_offer"
                else:
                    product_offer_peracentage = product.product_offer.percentage
                    product_saleprice = float(product.sale_price)
                    product_offer_price = product_saleprice - \
                        product_saleprice*product_offer_peracentage/100
                    product.product_offer_price = product_offer_price
                    product.offer_type = "product_offer"
            else:
                product.product_offer = None
                product.product_offer_price = None
                product.offer_type = None

        if request.POST.get('product_image') != None and request.POST.get('product_image') != "":
            product_image_base64 = request.POST['product_image']
            format, img1 = product_image_base64.split(';base64,')
            ext = format.split('/')[-1]
            product_image_cropped = ContentFile(base64.b64decode(
                img1), name=product_name + '1.' + ext)
            product.image = product_image_cropped
        product.save()

        # existing gallery images
        if request.POST.get('product_gallery1') != None and request.POST.get('product_gallery1') != "":
            gallery_image_id = request.POST['gallery_image_id1']
            product_gallery = ProductImages.objects.get(
                id=gallery_image_id)
            product_gallery1 = request.POST['product_gallery1']
            format, img2 = product_gallery1.split(';base64,')
            ext1 = format.split('/')[-1]
            gallery_image_cropped1 = ContentFile(base64.b64decode(
                img2), name=product_name + '2.' + ext1)
            product_gallery.image = gallery_image_cropped1
            product_gallery.save()

        if request.POST.get('product_gallery2') != None and request.POST.get('product_gallery2') != "":
            gallery_image_id = request.POST['gallery_image_id2']
            product_gallery = ProductImages.objects.get(
                id=gallery_image_id)
            product_gallery2 = request.POST['product_gallery2']
            format, img3 = product_gallery2.split(';base64,')
            ext2 = format.split('/')[-1]
            gallery_image_cropped2 = ContentFile(base64.b64decode(
                img3), name=product_name + '3.' + ext2)
            product_gallery.image = gallery_image_cropped2
            product_gallery.save()

        if request.POST.get('product_gallery3') != None and request.POST.get('product_gallery3') != "":
            gallery_image_id = request.POST['gallery_image_id3']
            product_gallery = ProductImages.objects.get(
                id=gallery_image_id)
            product_gallery3 = request.POST['product_gallery3']
            format, img4 = product_gallery3.split(';base64,')
            ext3 = format.split('/')[-1]
            gallery_image_cropped3 = ContentFile(base64.b64decode(
                img4), name=product_name + '4.' + ext3)
            product_gallery.image = gallery_image_cropped3
            product_gallery.save()

        if request.POST.get('product_gallery4') != None and request.POST.get('product_gallery4') != "":
            gallery_image_id = request.POST['gallery_image_id4']
            product_gallery = ProductImages.objects.get(
                id=gallery_image_id)
            product_gallery4 = request.POST['product_gallery4']
            format, img5 = product_gallery4.split(';base64,')
            ext4 = format.split('/')[-1]
            gallery_image_cropped4 = ContentFile(base64.b64decode(
                img5), name=product_name + '5.' + ext4)
            product_gallery.image = gallery_image_cropped4
            product_gallery.save()

        # new gallery images
        if request.POST.get('gallery_image_add_id') != None and request.POST.get('gallery_image_add_id') != "":
            new_gallery_image = request.POST['gallery_image_add_id']
            new_gallery_image = Products.objects.get(id=new_gallery_image)
            if request.FILES.get('new_product_gallery1') != None and request.FILES.get('product_gallery1') != "":
                new_product_gallery1 = request.FILES['new_product_gallery1']
                gallery_image = ProductImages.objects.create(
                    product=new_gallery_image, image=new_product_gallery1)
            if request.FILES.get('new_product_gallery2') != None and request.FILES.get('product_gallery2') != "":
                new_product_gallery2 = request.FILES['new_product_gallery2']
                gallery_image = ProductImages.objects.create(
                    product=new_gallery_image, image=new_product_gallery2)
            if request.FILES.get('new_product_gallery3') != None and request.FILES.get('product_gallery3') != "":
                new_product_gallery3 = request.FILES['new_product_gallery3']
                gallery_image = ProductImages.objects.create(
                    product=new_gallery_image, image=new_product_gallery3)
            if request.FILES.get('new_product_gallery4') != None and request.FILES.get('product_gallery4') != "":
                new_product_gallery4 = request.FILES['new_product_gallery4']
                gallery_image = ProductImages.objects.create(
                    product=new_gallery_image, image=new_product_gallery4)
        return redirect(productList)
    else:
        gallery_images = ProductImages.objects.filter(
            product=product_id).order_by('-id')
        edit_product_data = Products.objects.get(id=product_id)
        product_data = SubCategory.objects.all()
        offers = Offer.objects.all()
        context = {
            'edit_product_data': edit_product_data,
            'product_data': product_data,
            'gallery_images': gallery_images,
            'offers': offers
        }
        return render(request, 'products/productEdit.html', context)


def productDetails(request, product_id):
    all_products = Products.objects.all()
    product_gallery = ProductImages.objects.filter(product=product_id)
    product_details = Products.objects.get(id=product_id)
    context = {'product_details': product_details,
               'product_gallery': product_gallery,
               'all_products': all_products}
    return render(request, 'store/productDetails.html', context)


@login_required(login_url='adminLogin')
def productDelete(request, product_id):
    Products.objects.filter(id=product_id).delete()
    return redirect(productList)


def listProductsPage(request, category_slug=None):
    print("cat-slug", category_slug)
    categories = None
    all_products = None
    if category_slug != None:
        categories = get_object_or_404(SubCategory, slug=category_slug)
        all_products = Products.objects.filter(category=categories)
    else:
        all_products = Products.objects.all()
    context = {'all_products': all_products, }

    return render(request, 'store/listProductsPage.html', context)


def search(request):
    if 'search_keyword' in request.GET:
        search_keyword = request.GET['search_keyword']
        if search_keyword:
            all_products = Products.objects.order_by(
                '-created_date').filter(Q(product_name__icontains=search_keyword) | Q(description__icontains=search_keyword))
            context = {'all_products': all_products}
    return render(request, 'store/listProductsPage.html', context)


def wishlist(request, total=0, quantity=0, wishlist_items=None):
    try:
        if request.user.is_authenticated:
            user = Wishlist.objects.get(user=user_id(request))
            wishlist_items = WishListItem.objects.filter(
                wishlist=user, is_active=True).order_by('-id')
            for wishlist_item in wishlist_items:
                if wishlist_item.product.product_offer:
                    total += (wishlist_item.product.product_offer_price *
                              wishlist_item.quantity)
                    quantity += wishlist_item.quantity
                else:
                    total += (wishlist_item.product.sale_price *
                              wishlist_item.quantity)
                    quantity += wishlist_item.quantity
        else:
            user = Wishlist.objects.get(wishlist_id=user_id(request))
            wishlist_items = WishListItem.objects.filter(
                wishlist=user, is_active=True).order_by('-id')
            for wishlist_item in wishlist_items:
                if wishlist_item.product.product_offer:
                    total += (wishlist_item.product.product_offer_price *
                              wishlist_item.quantity)
                    quantity += wishlist_item.quantity
                else:
                    total += (wishlist_item.product.sale_price *
                              wishlist_item.quantity)
                    quantity += wishlist_item.quantity

    except ObjectDoesNotExist:
        pass
    context = {
        'total': total,
        'quantity': quantity,
        'wishlist_items': wishlist_items,
    }
    return render(request, 'store/wishlist.html', context)


def add_wishlist(request):
    product_id = request.GET['product_id']
    if request.GET.get('product_variations') != None:
        product_size = request.GET['product_variations']
    if request.user.is_authenticated:
        product = Products.objects.get(id=product_id)
        try:
            wishlist = Wishlist.objects.get(user=user_id(request))
        except Wishlist.DoesNotExist:
            wishlist = Wishlist.objects.create(user=user_id(request))
        wishlist.save()
        try:
            wishlist_item = WishListItem.objects.get(
                product=product, wishlist=wishlist)
            wishlist_item.quantity += 1
            if request.GET.get('product_variations') != None:
                wishlist_item.variation = product_size
            wishlist_item.save()
        except WishListItem.DoesNotExist:
            if request.GET.get('product_variations') != None:
                wishlist_item = WishListItem.objects.create(
                    product=product, wishlist=wishlist, quantity=1, variation=product_size)
            else:
                wishlist_item = WishListItem.objects.create(
                    product=product, wishlist=wishlist, quantity=1)
            wishlist_item.save()
        return redirect('wishlist')
    else:
        print("user auth none")
        product = Products.objects.get(id=product_id)
        try:
            wishlist = Wishlist.objects.get(wishlist_id=user_id(request))
        except Wishlist.DoesNotExist:
            wishlist = Wishlist.objects.create(wishlist_id=user_id(request))
        wishlist.save()
        try:
            wishlist_item = WishListItem.objects.get(
                product=product, wishlist=wishlist)
            wishlist_item.quantity += 1
            wishlist_item.save()
        except WishListItem.DoesNotExist:
            wishlist_item = WishListItem.objects.create(
                product=product, wishlist=wishlist, quantity=1)
            wishlist_item.save()
        return JsonResponse("successful", safe=False)


def WishListRemoveProduct(request):
    product_id = request.GET['product_id']
    product_instance = Products.objects.get(id=product_id)
    WishListItem.objects.filter(product=product_instance).delete()
    return redirect('wishlist')


@csrf_exempt
def wishlist_cart_decrement(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        user = request.user
        user_instance = Wishlist.objects.get(user=user)
        update_quantity = WishListItem.objects.get(
            wishlist=user_instance, product=product)
        if update_quantity.quantity >= 2:
            update_quantity.quantity -= 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
    else:
        session_key = request.session.session_key
        session_instance = Wishlist.objects.get(wishlist_id=session_key)
        update_quantity = WishListItem.objects.get(
            wishlist=session_instance, product=product)
        if update_quantity.quantity >= 2:
            update_quantity.quantity -= 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
    # updating prodduct cart subtotal(not necessary bcoz its already done in models.py))
    sub_total = update_quantity.product.sale_price * update_quantity.quantity
    return JsonResponse({'sub_total': sub_total, 'new_quantity': new_quantity})


@csrf_exempt
def wishlist_input_cart(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)
    wishlist_input = request.POST['cart_input']

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        user = request.user
        user_instance = Wishlist.objects.get(user=user)
        update_quantity = WishListItem.objects.get(
            wishlist=user_instance, product=product)
        update_quantity.quantity = wishlist_input
        update_quantity.save()
    else:
        session_key = request.session.session_key
        session_instance = Wishlist.objects.get(wishlist_id=session_key)
        update_quantity = WishListItem.objects.get(
            wishlist=session_instance, product=product)
        if wishlist_input >= 1:
            update_quantity.quantity = wishlist_input
            update_quantity.save()
    return JsonResponse("success", safe=False)


@csrf_exempt
def wishlist_cart_increment(request):
    product_id = request.POST['id']
    product = Products.objects.get(id=product_id)

    # updating prodduct cart quantity
    if request.user.is_authenticated:
        user = request.user
        user_instance = Wishlist.objects.get(user=user)
        update_quantity = WishListItem.objects.get(
            wishlist=user_instance, product=product)
        if product.stock > update_quantity.quantity:
            update_quantity.quantity += 1
            update_quantity.save()
            new_quantity = update_quantity.quantity
        else:
            messages.alert(request, "product is out of stock",
                           extra_tags="out_stock_error")

    else:
        session_key = request.session.session_key
        session_instance = Wishlist.objects.get(wishlist_id=session_key)
        update_quantity = WishListItem.objects.get(
            wishlist=session_instance, product=product)
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
