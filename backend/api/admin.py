from django.contrib import admin

from api.models import Akun, Food, MedicalRecord

# Register your models here.

@admin.register(Akun)
class AkunAdmin(admin.ModelAdmin):
    list_display = [f.name for f in Akun._meta.fields]

@admin.register(MedicalRecord)
class MedicalRecordAdmin(admin.ModelAdmin):
    list_display = [f.name for f in MedicalRecord._meta.fields]

# @admin.register(Food)
# class FoodAdmin(admin.ModelAdmin):
#     list_display = [f.name for f in Food._meta.fields]

admin.site.register(Food)
