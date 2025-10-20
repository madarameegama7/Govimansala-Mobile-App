// lib/pages/my_products/add_product_dialog.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/farmer_product.dart';
import '../../services/farmerproduct_service.dart';
import 'package:flutter/foundation.dart';


class AddProductDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;

  const AddProductDialog({
    super.key,
    this.product,
    required this.onSave,
  });

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedCategory = 'Vegetables';
  String _selectedStatus = 'AVAILABLE';
  bool _isOrganic = false;
  DateTime? _harvestDate;
  DateTime? _expiryDate;

  String? _organicCertificatePath;

  // For Web: store picked file name and bytes
String? _organicCertificateFileName;
Uint8List? _organicCertificateBytes;


  final List<String> _categories = ['Vegetables', 'Fruits', 'Grains', 'Dairy', 'Other'];
  final List<String> _statusOptions = ['AVAILABLE', 'OUT_OF_STOCK', 'DISCONTINUED'];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toStringAsFixed(0);
      _stockController.text = widget.product!.stock.toString();
      _descriptionController.text = widget.product!.description;
      _locationController.text = widget.product!.location;
      _selectedCategory = widget.product!.category;
      _selectedStatus = widget.product!.status;
      _isOrganic = widget.product!.isOrganic;
      _harvestDate = widget.product!.harvestDate;
      _expiryDate = widget.product!.expiryDate;
      _organicCertificatePath = widget.product!.organicCertificatePath;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isHarvestDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isHarvestDate
          ? _harvestDate ?? DateTime.now()
          : _expiryDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: isHarvestDate
          ? DateTime.now().subtract(const Duration(days: 365))
          : DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isHarvestDate) {
          _harvestDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  Future<void> _pickOrganicCertificate() async {
  if (kIsWeb) {
    // Handle web file picking (FilePicker supports limited web)
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      setState(() {
        _organicCertificateFileName = fileName;
        _organicCertificateBytes = fileBytes;
      });
    }
  } else {
    // Mobile/Desktop
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _organicCertificatePath = result.files.first.path;
      });
    }
  }
}


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id,
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text),
        description: _descriptionController.text.trim(),
        imageUrl: FarmerProductService.getProductImage(_nameController.text.trim()),
        category: _selectedCategory,
        stock: int.parse(_stockController.text),
        location: _locationController.text.trim(),
        isOrganic: _isOrganic,
        organicCertificatePath: _organicCertificatePath,
        status: _selectedStatus,
        harvestDate: _harvestDate,
        expiryDate: _expiryDate,
      );

      widget.onSave(product);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter product name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price Per Kg(Rs.)',
                        border: OutlineInputBorder(),
                        prefixText: 'Rs. ',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter price';
                        if (double.tryParse(value) == null) return 'Please enter valid price';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      decoration: const InputDecoration(
                        labelText: 'Stock in kg',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter stock';
                        if (int.tryParse(value) == null) return 'Please enter valid stock';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please enter location' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statusOptions
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status.replaceAll('_', ' ')),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Organic Product'),
                value: _isOrganic,
                onChanged: (value) {
                  setState(() {
                    _isOrganic = value;
                    if (!_isOrganic) _organicCertificatePath = null;
                  });
                },
              ),
              if (_isOrganic) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickOrganicCertificate,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload Organic Certificate'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _organicCertificatePath != null
                            ? _organicCertificatePath!.split('/').last
                            : 'No file selected',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Harvest Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_harvestDate != null
                                ? '${_harvestDate!.day}/${_harvestDate!.month}/${_harvestDate!.year}'
                                : 'Select Date'),
                            const Icon(Icons.calendar_today, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_expiryDate != null
                                ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                                : 'Select Date'),
                            const Icon(Icons.calendar_today, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
