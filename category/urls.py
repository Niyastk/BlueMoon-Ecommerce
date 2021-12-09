
from django.urls.conf import path
from . import views

urlpatterns = [
    path('ParentCategoryList/', views.ParentCategoryList,
         name='ParentCategoryList'),
    path('SubCategoryList/', views.SubCategoryList, name='SubCategoryList'),
    path('categoryAdd/', views.categoryAdd, name='categoryAdd'),
    path('SubCategoryAdd/', views.SubCategoryAdd, name='SubCategoryAdd'),
    path('ParentCategoryAdd/', views.ParentCategoryAdd, name='ParentCategoryAdd'),
    path('parentCategoryEdit/<int:parent_category_id>',
         views.parentCategoryEdit, name='parentCategoryEdit'),
    path('subCategoryEdit/<int:sub_category_id>',
         views.subCategoryEdit, name='subCategoryEdit'),
    path('parentCategoryDelete/<int:parent_category_id>',
         views.parentCategoryDelete, name='parentCategoryDelete'),
    path('subCategoryDelete/<int:sub_category_id>',
         views.subCategoryDelete, name='subCategoryDelete'),
]
 