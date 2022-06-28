# Generated by Django 4.0.3 on 2022-04-05 01:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Akun',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=256)),
                ('password', models.CharField(max_length=256)),
                ('is_admin', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='Food',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama', models.CharField(max_length=512)),
                ('energy', models.FloatField(blank=True, null=True)),
                ('carbo', models.FloatField(blank=True, null=True)),
                ('sugar', models.FloatField(blank=True, null=True)),
                ('protein', models.FloatField(blank=True, null=True)),
                ('fat', models.FloatField(blank=True, null=True)),
                ('fiber', models.FloatField(blank=True, null=True)),
                ('cholestrol', models.FloatField(blank=True, null=True)),
                ('pic_url', models.FloatField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Konselor',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama', models.CharField(blank=True, max_length=512, null=True)),
                ('date_employee', models.DateField(blank=True, null=True)),
                ('nomor_induk', models.CharField(blank=True, max_length=30, null=True)),
                ('tipe', models.CharField(max_length=30)),
                ('akun', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.akun')),
            ],
        ),
        migrations.CreateModel(
            name='Mood',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=30, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Obat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama', models.CharField(blank=True, max_length=512, null=True)),
                ('jenis', models.CharField(blank=True, max_length=512, null=True)),
                ('harga', models.FloatField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Pasien',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama', models.CharField(blank=True, max_length=512, null=True)),
                ('nomor_induk', models.CharField(blank=True, max_length=30, null=True)),
                ('tgl_lahir', models.DateField(blank=True, null=True)),
                ('alamat_tinggal', models.CharField(blank=True, max_length=512, null=True)),
                ('alamat_kirim', models.CharField(blank=True, max_length=512, null=True)),
                ('email', models.CharField(blank=True, max_length=100, null=True)),
                ('no_hp', models.CharField(blank=True, max_length=20, null=True)),
                ('akun', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.akun')),
            ],
        ),
        migrations.CreateModel(
            name='PaketObat',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('status', models.CharField(blank=True, max_length=100, null=True)),
                ('akun', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.akun')),
                ('obat', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.obat')),
            ],
        ),
        migrations.CreateModel(
            name='MoodTracking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('heartRate', models.FloatField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('mood', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.mood')),
                ('pasien', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.pasien')),
            ],
        ),
        migrations.CreateModel(
            name='KonsultasiRecord',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('diagnosa', models.CharField(blank=True, max_length=512, null=True)),
                ('treatment', models.CharField(blank=True, max_length=512, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('konselor', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.konselor')),
                ('pasien', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.pasien')),
            ],
        ),
    ]
