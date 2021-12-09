
from django.urls.conf import path
from . import views

urlpatterns = [
    path('productAdd/', views.productAdd, name='productAdd'),
    path('productList/', views.productList, name='productList'),
    path('listProductsPage/', views.listProductsPage, name='listProductsPage'),
    path('category/<slug:category_slug>/', views.listProductsPage,
         name='products_by_category'),
    path('search/', views.search, name='search'),
    path('productEdit/<int:product_id>', views.productEdit, name='productEdit'),
    path('productDelete/<int:product_id>',
         views.productDelete, name='productDelete'),
    path('productDetails/<int:product_id>',
         views.productDetails, name='productDetails'),
    path('wishlist/', views.wishlist, name='wishlist'),
    path('add_wishlist/', views.add_wishlist, name='add_wishlist'),
    path('WishListRemoveProduct/', views.WishListRemoveProduct,
         name='WishListRemoveProduct'),
    path('wishlist_cart_decrement/', views.wishlist_cart_decrement,
         name='wishlist_cart_decrement'),
    path('wishlist_input_cart/', views.wishlist_input_cart,
         name='wishlist_input_cart'),
    path('wishlist_cart_increment/', views.wishlist_cart_increment,
         name='wishlist_cart_increment'),


]
