## Tugas 7
### Perbedaan _stateless_ dan _stateful widget_ dalam konteks pengembangan aplikasi flutter
_Stateless widget_ adalah widget yang tidak memiliki _state_, yang berarti mereka tidak dapat mengubah dirinya sendiri melalui aksi internal. _Stateless widget_ dapat berubah ketika terjadi _external events_ yang berasal dari _parent widgets_ pada _widgets tree_
<br>

_Stateless widgets_ akan menerima deskripsinya dari parentnya. Ia tidak dapat mengubah deskripsi dirinya sendiri. _Stateless widgets_ hanya memiliki properti **final** saat konstruksinya. Widgets ini yang akan ditampilkan pada layar device. Contoh dari _stateless widgets_ adalah sebagai berikut:
```
class Frog extends StatelessWidget {
  const Frog({
    super.key,
    this.color = const Color(0xFF2DBD3A),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: color, child: child);
  }
}
``` 
<br>

_Stateful widgets_ adalah widgets yang dapat berubah secara dinamis ketika terjadi perubahan data. _Stateful widgets_ bersifat immutable, namun memiliki class company State yang merepresentasi state dari widget tersebut. Contoh dari _stateful widgets_ adalah sebagai berikut:
```
class Bird extends StatefulWidget {
  const Bird({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: widget.child,
    );
  }
}
```

### Widget yang digunakan pada tugas ini serta fungsinya
<ol>
<li> MaterialApp</li>
Merupakan root widget pada widget tree yang berguna untuk mengkonfigurasi penampilan aplikasi secara keseluruhan serta alur kerja dari aplikasi flutter kita

<br>
<li>Scaffold</li>
Scaffold widget berguna sebagai kerangka dari aplikasi flutter kita. Dia berfungsi sebagai kontainer untuk berbagai macam widget lain

<br>
<li>Appbar</li>
Widget yang tampil di paling atas layar. Biasanya berguna untuk menampilkan judul aplikasi

<br>
<li>SingleChildScrollView</li>
Widget yang membuat aplikasi kita dapat di-scroll ketika konten berada di luar layar

<br>
<li>Padding</li>
Widget yang digunakan untuk menambah padding

<br>
<li>Column</li>
Widget yang digunakan untuk menampilkan item secara vertikal di sebuah kolom

<br>
<li>Text</li>
Widget yang digunakan untuk menampilkan text di layar

<br>
<li>GridView.count</li>
Widget yang digunakan untuk mengspefikasikan childrennya untuk berada di grid nomor berapa

<br>
<li>Icon</li>
Widget yang digunakan untuk menampilkan icon

<br>
<li>InkWell</li>
Widget yang membuat sebuah area dapat menerima feedback

<br>
<li>SnackBar</li>
Widget yang membuat sebuah temporary message di bagian bawah layar
</ol>

### Pengimplementasian checklist secara step-by-step
1. Menginstall [Flutter](https://docs.flutter.dev/get-started/install) dan [Android Studio](https://developer.android.com/studio) seperti yang ada di dokumentasi websitenya

2. Membuat proyek baru bernama **rey_inventory** dengan menjalankan `flutter create rey_inventory`

3. Menjalankan perintah `flutter config --enable-web` untuk enable web support

4. Membuat file baru bernama `menu.dart`, lalu isi dengan kode seperti berikut untuk membuat tampilan aplikasi yang berisi tiga tombol serta mengeluarkan SnackBar ketika diklik
```
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<ShopItem> items = [
    ShopItem("Lihat Produk", Icons.checklist, Colors.deepOrange),
    ShopItem("Tambah Produk", Icons.add_shopping_cart, Colors.deepPurple),
    ShopItem("Logout", Icons.logout, Color.fromARGB(255, 98, 196, 12)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Shopping List',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'PBP Shop', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

5. Memodifikasi file `main.dart` agar mengextend _stateless widgets_ yang berisi seperti ini
```
import 'package:flutter/material.dart';
import 'package:rey_inventory/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

```

6. Untuk mengerjakan bonus, modifikasi class ShopItem agar memiliki atribut warna serta mengubah constructornya agar dapat menerima argumen berupa color
```
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```
Kemudian, mengubah Widget build nya agar warna nya menjadi sesuai dengan input dari parameter
```
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        . . .
```