from django.db import models

class Akun(models.Model):
    nama = models.CharField(max_length=255, null=False, blank=False)
    nim = models.CharField(max_length=255, null=False, blank=False, unique=True)
    email = models.CharField(max_length=255, null=False, blank=False)
    username = models.CharField(max_length=255, null=False, blank=False)
    password = models.CharField(max_length=255, null=False, blank=False)
    is_admin = models.BooleanField(default=False)
    is_konselor = models.BooleanField(default=False)
    is_pasien = models.BooleanField(default=True)

    def __str__(self):
        return self.nama

class MedicalRecord(models.Model):
    pasien = models.ForeignKey(Akun, to_field="nim", on_delete=models.CASCADE)
    diagnosa = models.CharField(max_length=512, null=False, blank=False)
    treatment = models.CharField(max_length=512, null=False, blank=False)

class Food(models.Model):
    nama = models.CharField(max_length=512, null=False, blank=False)
    energy = models.FloatField(null=True, blank=True)
    carbo = models.FloatField(null=True, blank=True)
    sugar = models.FloatField(null=True, blank=True)
    protein = models.FloatField(null=True, blank=True)
    fat = models.FloatField(null=True, blank=True)
    fiber = models.FloatField(null=True, blank=True)
    cholestrol = models.FloatField(null=True, blank=True)
    pic_url = models.FloatField(null=True, blank=True)