# Generated by Django 4.0.5 on 2022-06-27 07:29

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_delete_feedback_remove_konselor_akun_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Akun',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama', models.CharField(max_length=255)),
                ('nim', models.CharField(max_length=255, unique=True)),
                ('email', models.CharField(max_length=255)),
                ('username', models.CharField(max_length=255)),
                ('password', models.CharField(max_length=255)),
                ('is_admin', models.BooleanField(default=False)),
                ('is_konselor', models.BooleanField(default=False)),
                ('is_pasien', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='MedicalRecord',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('diagnosa', models.CharField(max_length=512)),
                ('treatment', models.CharField(max_length=512)),
                ('pasien', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.akun', to_field='nim')),
            ],
        ),
    ]