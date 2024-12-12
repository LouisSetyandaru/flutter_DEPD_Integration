part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewModel homeViewModel = HomeViewModel();
  final TextEditingController _weightController = TextEditingController();
  dynamic selectedProvinceOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedProvinceDestination;
  dynamic selectedCityDestination;
  dynamic selectedCourier;
  List<String> courierLists = ["jne", "pos", "tiki"];

  @override
  void initState() {
    super.initState();
    homeViewModel.getProvinceList();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Cek Ongkir Mazzeh",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (_) => homeViewModel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // pilihan kurir
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCourier,
                            icon: const Icon(Icons.arrow_drop_down),
                            hint: const Text("Pilih kurir"),
                            items: courierLists.map<DropdownMenuItem<String>>(
                                (String courier) {
                              return DropdownMenuItem<String>(
                                value: courier,
                                child: Text(courier.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCourier = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Input Berat Barang 
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Berat barang (gr)",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Provinsi Awal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                // Pilohan Provinsi Asal
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedProvinceOrigin,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Provinsi"),
                                  items: value.provinceList.data!
                                      .map<DropdownMenuItem<Province>>(
                                          (Province value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedProvinceOrigin = newValue;
                                      selectedCityOrigin = null;
                                    });
                                    if (newValue != null) {
                                      homeViewModel.getCityListOrigin(
                                          selectedProvinceOrigin.provinceId);
                                    }
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Pilihan Kota Asal
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.cityListOrigin.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                    value.cityListOrigin.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedCityOrigin,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Kota"),
                                  items: value.cityListOrigin.data!
                                      .map<DropdownMenuItem<City>>(
                                          (City value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCityOrigin = newValue;
                                    });
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Provinsi Tujuan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 2),
                // Pilihan Provinsi 
                Row(
                  children: [
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedProvinceDestination,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Provinsi"),
                                  items: value.provinceList.data!
                                      .map<DropdownMenuItem<Province>>(
                                          (Province value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedProvinceDestination = newValue;
                                      selectedCityDestination = null;
                                    });
                                    if (newValue != null) {
                                      homeViewModel.getCityListDestination(
                                          selectedProvinceDestination
                                              .provinceId);
                                    }
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Pilihan Tujuan Kota 
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.cityListDestination.status) {
                            case Status.loading:
                              return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            case Status.error:
                              return Align(
                                alignment: Alignment.center,
                                child: Text(value.cityListDestination.message
                                    .toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                  isExpanded: true,
                                  value: selectedCityDestination,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text("Pilih Kota"),
                                  items: value.cityListDestination.data!
                                      .map<DropdownMenuItem<City>>(
                                          (City value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCityDestination = newValue;
                                    });
                                  });
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Cek Harga Ongkir
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCourier != null &&
                          selectedProvinceOrigin != null &&
                          selectedCityOrigin != null &&
                          selectedProvinceDestination != null &&
                          selectedCityDestination != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Mohon ditunggu Mazzeh 🫡"),
                        ));
                        homeViewModel.getCostList(
                          selectedProvinceOrigin.toString(),
                          selectedCityOrigin.cityId.toString(),
                          selectedProvinceDestination.toString(),
                          selectedCityDestination.cityId.toString(),
                          int.tryParse(_weightController.text.trim()) ?? 0,
                          selectedCourier.toString(),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Data harus lengkap ya Mazzeh"),
                        ));
                      }
                    },
                    child: const Text(
                      "Cek Harga",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Ubah warna tombol ke hijau
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                      ),
                      textStyle: const TextStyle(
                        fontSize: 12, // Size of the text // Bold text
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Consumer<HomeViewModel>(
                  builder: (context, value, _) {
                    if (value.costList.status == Status.loading) {
                      return const Center(
                          child: Text("Mohon diisi data diatas"));
                    } else if (value.costList.status == Status.error) {
                      return Center(
                          child: Text("Error: ${value.costList.message}"));
                    } else if (value.costList.status == Status.completed) {
                      final costData =
                          value.costList.data; 
                      if (costData != null && costData.isNotEmpty) {
                        return Column(
                          children: costData.map((costs) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              surfaceTintColor:
                                  const Color.fromARGB(255, 0, 255, 0),
                              child: ListTile(
                                title:
                                    Text(costs.service.toString() ?? "Invalid"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, 
                                  children: [
                                    Text("Layanan: ${costs.service ?? "-"}"),
                                    Text(
                                        "Harga: Rp${costs.cost![0].value ?? 0}"),
                                    Text(
                                        "Estimasi Hari: ${costs.cost![0].etd ?? ""}"),
                                    
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text("No costs available.");
                      }
                    } else {
                      return Container(); 
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//--Back Up Code---


// class _CostPageState extends State<CostPage> {
  // HomeViewModel homeViewModel = HomeViewModel();
//   @override
//   void initState() {
//     homeViewModel.getProvinceList();
//     super.initState();
//   }

//   dynamic selectedProvince;
//     dynamic selectedCity;
//   // dynamic selectedDataProvince;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown,
//         title: Text(
//           "Calculate Cost",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: ChangeNotifierProvider<HomeViewModel>(
//         create: (context) => homeViewModel,
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: Column(
//             children: [
//               Flexible(
//                   flex: 1,
//                   child: Card(
//                     color: Colors.white,
//                     elevation: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           //dropdown province list
//                           Consumer<HomeViewModel>(builder: (context, value, _) {
//                             switch (value.provinceList.status) {
//                               case Status.loading:
//                                 return Align(
//                                   alignment: Alignment.center,
//                                   child: CircularProgressIndicator(),
//                                 );
//                               case Status.error:
//                                 return Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                       value.provinceList.message.toString()),
//                                 );
//                               case Status.completed:
//                                 return DropdownButton(
//                                     isExpanded: true,
//                                     value: selectedProvince,
//                                     icon: Icon(Icons.arrow_drop_down),
//                                     iconSize: 30,
//                                     elevation: 2,
//                                     hint: Text('Pilih Provinsi'),
//                                     style: TextStyle(color: Colors.black),
//                                     items: value.provinceList.data!
//                                         .map<DropdownMenuItem<Province>>(
//                                             (Province value) {
//                                       return DropdownMenuItem(
//                                           value: value,
//                                           child:
//                                               Text(value.province.toString()));
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedProvince = newValue;
//                                         selectedCity = null;
//                                         homeViewModel.getCityList(selectedProvince.provinceId);
//                                         // selectedProvinceId = selectedDataProvince.provinceId;
//                                       });
//                                     });
//                               default:
//                             }
//                             return Container();
//                           }),//dropdown province list
//                           Divider(height:16,),
//                           //dropdown city list
//                           Consumer<HomeViewModel>(builder: (context, value, _) {
//                             switch (value.cityList.status) {
//                               case Status.loading:
//                                 return Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text("Pilih Kota"),
//                                 );
//                               case Status.error:
//                                 return Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                       value.cityList.message.toString()),
//                                 );
//                               case Status.completed:
//                                 return DropdownButton(
//                                     isExpanded: true,
//                                     value: selectedCity,
//                                     icon: Icon(Icons.arrow_drop_down),
//                                     iconSize: 30,
//                                     elevation: 2,
//                                     hint: Text('Pilih Kota'),
//                                     style: TextStyle(color: Colors.black),
//                                     items: value.cityList.data!
//                                         .map<DropdownMenuItem<City>>(
//                                             (City value) {
//                                       return DropdownMenuItem(
//                                           value: value,
//                                           child:
//                                               Text(value.cityName.toString()));
//                                     }).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         selectedCity = newValue;
//                                         homeViewModel.getCityList(selectedCity.provinceId);
//                                         // selectedProvinceId = selectedDataProvince.provinceId;
//                                       });
//                                     });
//                               default:
//                             }
//                             return Container();
//                           }),//dropdown city list



//                         ],
//                       ),
//                     ),
//                   )),
//               Flexible(
//                   flex: 2,
//                   child: Container(
//                     color: Colors.brown.shade200,
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
