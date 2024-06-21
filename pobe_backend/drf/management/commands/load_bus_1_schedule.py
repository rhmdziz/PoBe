from django.core.management.base import BaseCommand
from drf.models import BusRoute, Halte, BusSchedule
import os
import csv
from datetime import datetime
from django.conf import settings

class Command(BaseCommand):
    help = 'Load bus schedule data from CSV file'

    def handle(self, *args, **kwargs):
        file_path = os.path.join(settings.BASE_DIR, 'drf', 'bus_schedule_csv', 'bus11.csv')

        with open(file_path, newline='', encoding='utf-8') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            
            current_route = None
            header = None
            

            for row in reader:
                if not row or all(cell.strip() == '' for cell in row):
                    continue

                if row[0].startswith('RUTE:'):
                    nama_rute = row[0].split(':')[1].strip()
                    current_route = BusRoute.objects.create(nama_rute=nama_rute)

                elif row[0].strip() == 'NO':
                    header = [col.strip() for col in row[2:]]

                elif row[0].isdigit():
                    nomor_bis = int(row[1].strip())
                    waktu_data = row[2:]

                    # Iterasi untuk setiap waktu dalam satu baris
                    for idx, waktu_str in enumerate(waktu_data):
                        waktu_str = waktu_str.strip()
                        if waktu_str and header and len(header) > idx:
                            waktu = datetime.strptime(waktu_str, '%H:%M').time()
                            halte_name = header[idx].strip()

                            # Cari atau buat objek Halte
                            current_halte, created = Halte.objects.get_or_create(nama_halte=halte_name)
                            if created:
                                self.stdout.write(self.style.SUCCESS(f'Halte baru berhasil dibuat: {current_halte.nama_halte}'))
                            

                            # Buat atau update objek BusSchedule
                            current_schedule, created = BusSchedule.objects.get_or_create(
                                rute=current_route,
                                nomor_bis=nomor_bis,
                                halte=current_halte,
                            )

                            print(idx, current_halte, nomor_bis)

                           

        self.stdout.write(self.style.SUCCESS('Data berhasil dimasukkan dari CSV'))
