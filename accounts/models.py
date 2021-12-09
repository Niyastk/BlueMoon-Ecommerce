from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager


# Create your models here.

class MyAccountManager(BaseUserManager):
    def create_user(self, first_name, last_name, username, email, phone_number, password=None):
        if not email:
            raise ValueError('user must have a valid email address')
        if not username:
            raise ValueError('user must have a username')
        user = self.model(
            email=self.normalize_email(email),
            username=username,
            first_name=first_name,
            last_name=last_name,
            phone_number=phone_number,)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, first_name, last_name, username, email, password):
        user = self.create_user(
            email=self.normalize_email(email),
            username=username,
            password=password,
            first_name=first_name,
            last_name=last_name,)
        user.is_admin = True
        user.is_active = True
        user.is_staff = True
        user.is_superadmin = True
        user.save(using=self._db)
        return user


class Account(AbstractBaseUser):
    first_name = models.CharField(max_length=50, blank=True)
    last_name = models.CharField(max_length=50, blank=True)
    username = models.CharField(max_length=50, unique=True, blank=True)
    email = models.EmailField(max_length=50, blank=True)
    phone_number = models.CharField(max_length=50, blank=True, unique=True)
    address = models.TextField(blank=True)
    referral_code = models.CharField(
        max_length=50, blank=True, null=True)
    wallet = models.IntegerField(blank=True, null=True, default=0)

    # required
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now_add=True)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_superadmin = models.BooleanField(default=False)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email', 'first_name', 'last_name']
    objects = MyAccountManager()

    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, add_label):
        return True


class UserAddress(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50, blank=True)
    country = models.CharField(max_length=50)
    street_address = models.CharField(max_length=300)
    apartment = models.CharField(max_length=150, blank=True)
    town = models.CharField(max_length=150, blank=True)
    postcode = models.IntegerField()
    phone_number = models.CharField(max_length=15)
    email = models.EmailField(max_length=50, blank=True)
