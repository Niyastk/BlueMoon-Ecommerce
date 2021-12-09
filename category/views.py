from django.db.models.base import Model
from django.shortcuts import redirect, render
from django.contrib import messages
from adminBluemoon.models import Offer
from category.models import Category, SubCategory
from store.models import Products

# Create your views here.


def ParentCategoryList(request):
    parentData = Category.objects.all()
    return render(request, 'admin/parentCategoryList.html', {'parentData': parentData})


def SubCategoryList(request):
    subData = SubCategory.objects.all()
    return render(request, 'admin/subCategoryList.html', {'subData': subData})


def categoryAdd(request):
    if request.method == 'POST':
        if request.POST.get('parent_category_id') == None:
            category_name = request.POST['category_name']
            slug = category_name.replace(" ", "-")
            category_description = request.POST['category_description']
            if category_name != "" and category_description != "":
                category = Category(category_name=category_name,
                                    slug=slug, descrption=category_description)
                category.save()
                return redirect(ParentCategoryList)
            else:
                category_data = Category.objects.all()
                return render(request, 'admin/parentCategory.html', {"category_data": category_data})
        else:
            category_name = request.POST['category_name']
            slug = category_name.replace(" ", "-")
            category_description = request.POST['category_description']
            parent_category_id = request.POST['parent_category_id']
            if category_name != "" and category_description != "":

                category_instance = Category.objects.get(id=parent_category_id)
                category = SubCategory(category_name=category_name,
                                       slug=slug, descrption=category_description, category_id=category_instance)
                category.save()
                return redirect(SubCategoryList)
            else:
                category_data = Category.objects.all()
                return render(request, 'admin/subCategory.html.html', {"category_data": category_data})
    else:
        category_data = Category.objects.all()
        return render(request, 'admin/categoryAdd.html', {"category_data": category_data})


def ParentCategoryAdd(request):
    if request.method == 'POST':
        category_name = request.POST['category_name']
        slug = category_name.replace(" ", "-")
        category_description = request.POST['category_description']
        if category_name != "":
            category = Category(category_name=category_name,
                                slug=slug, descrption=category_description)
            category.save()
            return redirect(ParentCategoryList)
        else:
            category_data = Category.objects.all()
            return render(request, 'admin/ParentCategoryAdd.html', {"category_data": category_data})
    else:
        category_data = Category.objects.all()
        return render(request, 'admin/ParentCategoryAdd.html', {"category_data": category_data})


def SubCategoryAdd(request):
    if request.method == 'POST':
        category_name = request.POST['category_name']
        slug = category_name.replace(" ", "-")
        category_description = request.POST['category_description']
        parent_category_id = request.POST['parent_category_id']
        if category_name != "":
            category_instance = Category.objects.get(id=parent_category_id)
            category = SubCategory(category_name=category_name,
                                   slug=slug, descrption=category_description, category_id=category_instance)
            category.save()
            return redirect(SubCategoryList)
        else:
            category_data = Category.objects.all()
            return render(request, 'admin/SubCategoryAdd.html', {"category_data": category_data})
    else:
        category_data = Category.objects.all()
        return render(request, 'admin/SubCategoryAdd.html', {"category_data": category_data})


def parentCategoryEdit(request, parent_category_id):
    if request.method == 'POST':
        category = Category.objects.get(id=parent_category_id)
        category_name = request.POST['category_name']
        category_description = request.POST['category_description']
        slug = category_name.replace(" ", "-")
        if category_name != "":
            category.category_name = category_name
            category.slug = slug
        if category_description != "":
            category.category_description = category_description
        category.save()
        print("parent cat updated")
        return redirect(ParentCategoryList)
    else:
        place_holder_data = Category.objects.get(id=parent_category_id)
        return render(request, 'admin/parentCategoryEdit.html', {"place_holder_data": place_holder_data})


def subCategoryEdit(request, sub_category_id):
    if request.method == 'POST':
        if request.POST.get('parent_category_id') == None:
            messages.info(request, 'Please Select a Parent category',
                          extra_tags="select_parent_category")
            place_holder_data = SubCategory.objects.get(id=sub_category_id)
            category_data = Category.objects.all()
            return render(request, 'admin/subCategoryEdit.html', {"category_data": category_data, "place_holder_data": place_holder_data})
        else:
            category = SubCategory.objects.get(id=sub_category_id)
            category_name = request.POST['category_name']
            category_description = request.POST['category_description']
            slug = category_name.replace(" ", "-")

            if request.POST.get('parent_category_id') != None and request.POST.get('parent_category_id') != "":
                parent_category_id = request.POST['parent_category_id']
                parent_category_instance = Category.objects.get(
                    id=parent_category_id)
                category.category_id = parent_category_instance

            if request.POST.get('offer_id') != None and request.POST.get('offer_id') != "":
                sub_category_offer = request.POST['offer_id']
                print("inside offer", sub_category_offer)
                if sub_category_offer != "None":
                    print("cat offer not none")
                    offer_instance = Offer.objects.get(id=sub_category_offer)
                    category.subcategory_offer = offer_instance
                    category_instance = SubCategory.objects.get(
                        id=sub_category_id)
                    products = Products.objects.filter(
                        category_id=category_instance)

                    for product in products:
                        if product.product_offer:
                            if product.product_offer.percentage <= category.subcategory_offer.percentage:
                                print("pro offer less than  cat offer")
                                product.offer_type = "category_offer"
                                product.product_offer = offer_instance
                                product.product_offer_price = product.sale_price - \
                                    (product.sale_price *
                                     category.subcategory_offer.percentage/100)
                                product.save()
                        else:
                            product.offer_type = "category_offer"
                            product.product_offer = offer_instance
                            product.product_offer_price = product.sale_price - \
                                (product.sale_price *
                                 category.subcategory_offer.percentage/100)
                            product.save()
                else:
                    category.subcategory_offer = None
                    category_instance = SubCategory.objects.get(
                        id=sub_category_id)
                    products = Products.objects.filter(
                        category=category_instance)
                    for product in products:
                        if product.product_offer:
                            if product.offer_type == "category_offer":
                                product.offer_type = None
                                product.product_offer = None
                                product.product_offer_price = None
                                product.save()

            if category_name != "":
                category.category_name = category_name
                category.slug = slug
            if category_description != "":
                category.category_description = category_description
            category.save()
            print("parent cat updated")
            return redirect(SubCategoryList)
    else:
        offers = Offer.objects.all()
        place_holder_data = SubCategory.objects.get(id=sub_category_id)
        category_data = Category.objects.all()
        return render(request, 'admin/subCategoryEdit.html', {"category_data": category_data, "place_holder_data": place_holder_data, 'offers': offers})


def parentCategoryDelete(request, parent_category_id):
    Category.objects.filter(id=parent_category_id).delete()
    return redirect(ParentCategoryList)


def subCategoryDelete(request, sub_category_id):
    SubCategory.objects.filter(id=sub_category_id).delete()
    return redirect(SubCategoryList)
