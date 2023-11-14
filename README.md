## Tugas 8

### Perbedaan Navigator.push() dan Navigator.pushReplacement()
Navigation pada flutter berfungsi untuk mengarahkan pengguna ke halaman yang mereka inginkan. Salah satu dari method yang terdapat pada class Navigator adalah .push() dan .pushReplacement(). 

* .push() digunakan untuk menambah layar baru pada posisi top dari stack Navigator. Hal ini memungkinkan pengguna untuk kembali ke layar sebelumnya dengan melakukan method .pop(). Contoh:
```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => newPage()),
);
```

* .pushReplacement() digunakan untuk mengganti layar yang sedang ditampilkan dengan layar lain. Hal ini membuat pengguna tidak dapat kembali ke layar sebelumnya karena layar sebelumnya sudah di-replace dengan layar yang baru

```
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HalamanBaru()),
);
```

Visualisasi : 
<br>
<img width="291" alt="image" src="https://github.com/reyhanwiyasa/rey_inventory_mobile/assets/119433464/671efd9b-e5f0-4b0e-9dea-742f0a0737b5">

### Layout widget pada flutter
Beberapa contoh layout widget pada flutter adalah :

1. Container

Digunakan sebagai box model yang dapat membungkus widget lain dan membiarkan kita untuk mengkustomisasi penampilan dan dimensi widget-widgetnya.

```
Container(
  padding: EdgeInsets.all(16.0),
  margin: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: Text('Hello, Flutter!'),
)
```

2. Row and Column

Mengatur posisi children widgetsnya agar menjadi horizontal (row) atau vertical (column)

```
Row(
  children: [
    Icon(Icons.star),
    Text('5.0'),
  ],
)

Column(
  children: [
    Text('First Name'),
    Text('Last Name'),
  ],
)
```

3. ListView

Membuat widget list yang dapat discroll

```
ListView(
  children: <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo),
      title: Text('Album'),
    ),
    // ...
  ],
)
```

4. GridView

Membuat widget grid yang dapat discroll
```
GridView.count(
  crossAxisCount: 2,
  children: <Widget>[
    Card(child: Text('Item 1')),
    Card(child: Text('Item 2')),
    // ...
  ],
)
```

### Elemen input pada form
Pada tugas ini, elemen input yang digunakan pada form adalah `TextFormField`. Elemen ini digunakan untuk menerima input teks dari user.

Beberapa manfaat dari TextFormField :

1. Memiliki Built-in Validation

TextFormField memiliki validator yang berguna untuk memvalidasi input dari pengguna. Jadi, form bisa mengecek apakah pengguna melanggar beberapa kriteria tertentu (misal formnya kosong, atau input melebihi panjang).

2. Input Decoration

TextFormField memiliki properti 'decoration', sehingga kita dapat dengan mudah mengubah tampilan input field yang ada di form.

3. Text Input Formatting

TextFormField memiliki properti 'inputFormatters' sehingga pengguna dapat memasukan custom format pada teks mereka. Misal menambahkan koma pada angka.

4. Obscure Text (Password input)

  TextFormField memiliki properti 'obscureText' untuk menutup informasi sensitif seperti password.

### Bagaimana penerapan clean architecture pada flutter?
Clean architecture adalah filosofi design yang bertujuan untuk membuat software yang maintainable dengan menggunakan konsep SoC dan meminimalisir dependancy.

Clean architecture pada flutter membagi codebase kita menjadi lapisan, dengan tanggung jawab dan dependency masing-masing. Umumnya, lapisan yang dimaksud adalah Presentation, Domain, dan Data. Presentation layer digunakan untuk berkomunikasi dengan use case (domain layer), dan domain layer akan  berinteraksi dengan repository (data layer) untuk melakukan read/write data

### Implementasi checklist secara step-by-step

1. Membuat drawer untuk navigasi.

```
import 'package:flutter/material.dart';
import 'package:rey_inventory/screens/menu.dart';
import 'package:rey_inventory/screens/shoplist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Rey Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Inventory gweh",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopFormPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

```

2. Membuat form page add item untuk memasukan input item yang kita mau. Form ini memanfaatkan TextFormField sehingga bisa langsung memvalidasi input pengguna juga.

```
import 'package:flutter/material.dart';
import 'package:rey_inventory/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
  const ShopFormPage({super.key});

  @override
  State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Produk',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Harga",
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _amount = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Harga harus berupa angka!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Jumlah: $_amount'),
                                  Text('Deskripsi: $_description'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    _formKey.currentState!.reset();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

```

3. Menambahkan drawer yang telah dibuat ke homepage

Pada file `menu.dart`, kita menambahkan drawer dalam widget Scaffold

```
return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Rey Inventory',
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
                  'PBP Inventory', // Text yang menandakan toko
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
      drawer: const LeftDrawer(),
    );
```
4. Memasukan variabel drawer tadi ke form

```
class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Produk',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      . . .
      . . .
```

5. Memberikan fungsi pada tombol Tambah Item

```
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
          if (item.name == "Tambah Produk") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopFormPage(),
                ));
          }
        },
        . . .
        . . .
```

6. Melakukan refactoring sehingga tampilannya seperti berikut :

<img width="93" alt="image" src="https://github.com/reyhanwiyasa/rey_inventory_mobile/assets/119433464/1818905f-019d-451f-9386-47135939ca77">


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

