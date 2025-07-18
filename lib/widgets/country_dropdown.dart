import 'package:flutter/material.dart';

class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});
}

class CountryDropdown extends StatelessWidget {
  final List<Country> countries;
  final Country? selectedCountry;
  final ValueChanged<Country?> onChanged;

  const CountryDropdown({
    super.key,
    required this.countries,
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Country>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
      ),
      isExpanded: true,
      hint: const Text('Select a country'),
      value: selectedCountry,
      items: countries.map((country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Row(
            children: [
              Text(
                country.flag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Text(country.name),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}