import 'package:eto_pay/widgets/country_dropdown.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

final List<Country> euCountries = [
  Country(name: 'Austria', flag: '🇦🇹'),
  Country(name: 'Belgium', flag: '🇧🇪'),
  Country(name: 'Croatia', flag: '🇭🇷'),
  Country(name: 'Czech Republic', flag: '🇨🇿'),
  Country(name: 'Denmark', flag: '🇩🇰'),
  Country(name: 'Estonia', flag: '🇪🇪'),
  Country(name: 'Finland', flag: '🇫🇮'),
  Country(name: 'France', flag: '🇫🇷'),
  Country(name: 'Germany', flag: '🇩🇪'),
  Country(name: 'Greece', flag: '🇬🇷'),
  Country(name: 'Hungary', flag: '🇭🇺'),
  Country(name: 'Ireland', flag: '🇮🇪'),
  Country(name: 'Italy', flag: '🇮🇹'),
  Country(name: 'Latvia', flag: '🇱🇻'),
  Country(name: 'Lithuania', flag: '🇱🇹'),
  Country(name: 'Luxembourg', flag: '🇱🇺'),
  Country(name: 'Malta', flag: '🇲🇹'),
  Country(name: 'Netherlands', flag: '🇳🇱'),
  Country(name: 'Poland', flag: '🇵🇱'),
  Country(name: 'Portugal', flag: '🇵🇹'),
  Country(name: 'Romania', flag: '🇷🇴'),
  Country(name: 'Slovakia', flag: '🇸🇰'),
  Country(name: 'Slovenia', flag: '🇸🇮'),
  Country(name: 'Spain', flag: '🇪🇸'),
  Country(name: 'Sweden', flag: '🇸🇪'),
];

Country? findCountryByName(String name) {
  return euCountries.firstWhereOrNull(
    (country) => country.name.toLowerCase() == name.toLowerCase(),
  );
}