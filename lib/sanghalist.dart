class SanghaUtility {
  static List<String?> getAllSanghaName() {
    var f = allSangha.map((s) => s.name);
    return f.toList();
  }
}

class Sangha {
  Sangha({this.name, this.district, this.state});
  String? district;
  String? state;
  String? name;
}

final allSangha = [
  Sangha(name: 'Angul', district: 'Angul'),
  Sangha(name: 'Bikrampur', district: 'Angul'),
  Sangha(name: 'Jagannathpur', district: 'Angul'),
  Sangha(name: 'Talcher', district: 'Angul'),
  Sangha(name: 'Nalconagar', district: 'Angul'),
  Sangha(name: 'Rankasinga', district: 'Angul'),
  Sangha(name: 'Samal Barrage', district: 'Angul'),
  Sangha(name: 'Ntpc', district: 'Angul'),
  Sangha(name: 'Athamallik', district: 'Angul'),
  Sangha(name: 'Asureswar', district: 'Cuttack'),
  Sangha(name: 'Cuttack', district: 'Cuttack'),
  Sangha(name: 'Kamarpada', district: 'Cuttack'),
  Sangha(name: 'Narsinghpur', district: 'Cuttack'),
  Sangha(name: 'Kendupatna', district: 'Cuttack'),
  Sangha(name: 'Kurunti', district: 'Cuttack'),
  Sangha(name: 'Baiyalish Mouza', district: 'Cuttack'),
  Sangha(name: 'Thermal Road', district: 'Cuttack'),
  Sangha(name: 'Tangi', district: 'Cuttack'),
  Sangha(name: 'Badamba', district: 'Cuttack'),
  Sangha(name: 'Barapada', district: 'Cuttack'),
  Sangha(name: 'Sukarapada', district: 'Cuttack'),
  Sangha(name: 'Niali', district: 'Cuttack'),
  Sangha(name: 'Gopalpur', district: 'Cuttack'),
  Sangha(name: 'Athagarh', district: 'Cuttack'),
  Sangha(name: 'Banki', district: 'Cuttack'),
  Sangha(name: 'khalarda', district: 'Cuttack'),
  Sangha(name: 'Bacchasailo', district: 'Cuttack'),
  Sangha(name: 'Endulapur', district: 'Kendrapara'),
  Sangha(name: 'Oupada', district: 'Kendrapara'),
  Sangha(name: 'kaitha', district: 'Kendrapara'),
  Sangha(name: 'katana', district: 'Kendrapara'),
  Sangha(name: 'Chandiagari', district: 'Kendrapara'),
  Sangha(name: 'Kurunti', district: 'Kendrapara'),
  Sangha(name: 'Gopei', district: 'Kendrapara'),
  Sangha(name: 'Gaudgaon', district: 'Kendrapara'),
  Sangha(name: 'Chhachina', district: 'Kendrapara'),
  Sangha(name: 'Jarimula', district: 'Kendrapara'),
  Sangha(name: 'Junapangara', district: 'Kendrapara'),
  Sangha(name: 'Tikhiri', district: 'Kendrapara'),
  Sangha(name: 'Tulasikhetra', district: 'Kendrapara'),
  Sangha(name: 'Deulipada', district: 'Kendrapara'),
  Sangha(name: 'Nadiabarai', district: 'Kendrapara'),
  Sangha(name: 'Naukona', district: 'Kendrapara'),
  Sangha(name: 'Rajnagar', district: 'Kendrapara'),
  Sangha(name: 'Naraharipur', district: 'Kendrapara'),
  Sangha(name: 'Adhanga', district: 'Kendrapara'),
  Sangha(name: 'Bijayanagar', district: 'Kendrapara'),
  Sangha(name: 'Nuagaon', district: 'Kendrapara'),
  Sangha(name: 'Matia', district: 'Kendrapara'),
  Sangha(name: 'Basudeipur', district: 'Kendrapara'),
  Sangha(name: 'Maharasahi', district: 'Kendrapara'),
  Sangha(name: 'Bilikana', district: 'Kendrapara'),
  Sangha(name: 'Mahakalapada', district: 'Kendrapara'),
  Sangha(name: 'Mandapada', district: 'Kendrapara'),
  Sangha(name: 'Rahama', district: 'Kendrapara'),
  Sangha(name: 'Rajkanika', district: 'Kendrapara'),
  Sangha(name: 'Rajpur', district: 'Kendrapara'),
  Sangha(name: 'Ramnagar', district: 'Kendrapara'),
  Sangha(name: 'Niala', district: 'Kendrapara'),
  Sangha(name: 'Singhaprahar', district: 'Kendrapara'),
  Sangha(name: 'Jaypore', district: 'Koraput'),
  Sangha(name: 'Damanjodi', district: 'Koraput'),
  Sangha(name: 'Semiliguda', district: 'Koraput'),
  Sangha(name: 'Balimela', district: 'Malkangiri'),
  Sangha(name: 'Kendra Sebak Sangha', district: 'Khordha'),
  Sangha(name: 'Rajdhani', district: 'Khordha'),
  Sangha(name: 'Atri', district: 'Khordha'),
  Sangha(name: 'Ekamra', district: 'Khordha'),
  Sangha(name: 'Banamalipur', district: 'Khordha'),
  Sangha(name: 'Begunia', district: 'Khordha'),
  Sangha(name: 'Khordha', district: 'Khordha'),
  Sangha(name: 'Bolagada', district: 'Khordha'),
  Sangha(name: 'Sanapadar', district: 'Khordha'),
  Sangha(name: 'Lanjiya', district: 'Ganjam'),
  Sangha(name: 'Badakheta', district: 'Ganjam'),
  Sangha(name: 'Tanarada', district: 'Ganjam'),
  Sangha(name: 'Sidharthnagar', district: 'Ganjam'),
  Sangha(name: 'Badamundilo', district: 'Jagatsinghpur'),
  Sangha(name: 'Jagatsinghpur', district: 'Jagatsinghpur'),
  Sangha(name: 'Rahama', district: 'Jagatsinghpur'),
  Sangha(name: 'Daradapatana', district: 'Jagatsinghpur'),
  Sangha(name: 'Mahisamunda', district: 'Jagatsinghpur'),
  Sangha(name: 'Nuabazar', district: 'Jagatsinghpur'),
  Sangha(name: 'Ersama', district: 'Jagatsinghpur'),
  Sangha(name: 'Haldpani', district: 'Jagatsinghpur'),
  Sangha(name: 'Paralakhemundi', district: 'Gajapati'),
  Sangha(name: 'Jharsuguda', district: 'Jharsuguda'),
  Sangha(name: 'Rasol', district: 'Dhenkanal'),
  Sangha(name: 'Kamakhyanagar', district: 'Dhenkanal'),
  Sangha(name: 'Dhenkanal', district: 'Dhenkanal'),
  Sangha(name: 'Balikiari', district: 'Dhenkanal'),
  Sangha(name: 'Kandarsingha', district: 'Dhenkanal'),
  Sangha(name: 'Indrabati', district: 'Nabarangapur'),
  Sangha(name: 'Nayagarh', district: 'Nayagarh'),
  Sangha(name: 'Thuabari', district: 'Nayagarh'),
  Sangha(name: 'Ranimunda', district: 'Nuapada'),
  Sangha(name: 'Khadiala', district: 'Nuapada'),
  Sangha(name: 'Duajhar', district: 'Nuapada'),
  Sangha(name: 'Baliguda', district: 'Kandhamala'),
  Sangha(name: 'Phulbani', district: 'Kandhamala'),
  Sangha(name: 'Bargarh', district: 'Bargarh'),
  Sangha(name: 'Nimapada', district: 'Puri'),
  Sangha(name: 'Puri Town', district: 'Puri'),
  Sangha(name: 'Balangir', district: 'Balangir'),
  Sangha(name: 'Silanda', district: 'Balangir'),
  Sangha(name: 'Raibania', district: 'Balasore'),
  Sangha(name: 'Kuagadia', district: 'Balasore'),
  Sangha(name: 'Kupari', district: 'Balasore'),
  Sangha(name: 'Garasang', district: 'Balasore'),
  Sangha(name: 'Nilagiri', district: 'Balasore'),
  Sangha(name: 'Antara', district: 'Balasore'),
  Sangha(name: 'Chittol', district: 'Balasore'),
  Sangha(name: 'Dantia', district: 'Balasore'),
  Sangha(name: 'Gud', district: 'Balasore'),
  Sangha(name: 'Balabhadrapur', district: 'Balasore'),
  Sangha(name: 'Mahatipur', district: 'Balasore'),
  Sangha(name: 'Soro', district: 'Balasore'),
  Sangha(name: 'Barapada', district: 'Balasore'),
  Sangha(name: 'Mahatipur1', district: 'Balasore'),
  Sangha(name: 'Mukteswarapur', district: 'Balasore'),
  Sangha(name: 'Fatehpur', district: 'Balasore'),
  Sangha(name: 'Gopinathpur', district: 'Balasore'),
  Sangha(name: 'Dandi', district: 'Balasore'),
  Sangha(name: 'Bainanda', district: 'Balasore'),
  Sangha(name: 'Sardar Vallabhbhai Patel Marg', district: 'Balasore'),
  Sangha(name: 'Matigada', district: 'Balasore'),
  Sangha(name: 'Dhusuli', district: 'Balasore'),
  Sangha(name: 'Jalahari', district: 'Bhadrak'),
  Sangha(name: 'Dhusuri', district: 'Bhadrak'),
  Sangha(name: 'Aradi', district: 'Bhadrak'),
  Sangha(name: 'Khadimahara', district: 'Bhadrak'),
  Sangha(name: 'Betada', district: 'Bhadrak'),
  Sangha(name: 'Basudevpur', district: 'Bhadrak'),
  Sangha(name: 'Paliabindha', district: 'Bhadrak'),
  Sangha(name: 'Gobindapur', district: 'Bhadrak'),
  Sangha(name: 'Paliabindha2', district: 'Bhadrak'),
  Sangha(name: 'Bhadrak', district: 'Bhadrak'),
  Sangha(name: 'Banitia', district: 'Bhadrak'),
  Sangha(name: 'Bacchada', district: 'Bhadrak'),
  Sangha(name: 'Pandupani', district: 'Mayurbhanja'),
  Sangha(name: 'Baripada', district: 'Mayurbhanja'),
  Sangha(name: 'Kundapatana', district: 'Jajapur'),
  Sangha(name: 'Dharmasala', district: 'Jajapur'),
  Sangha(name: 'Sobra', district: 'Jajapur'),
  Sangha(name: 'Kalakala', district: 'Jajapur'),
  Sangha(name: 'Kantigadia', district: 'Jajapur'),
  Sangha(name: 'Byasanagar Kanheipur', district: 'Jajapur'),
  Sangha(name: 'Jajapur Town', district: 'Jajapur'),
  Sangha(name: 'Kabatabandha', district: 'Jajapur'),
  Sangha(name: 'Palli', district: 'Jajapur'),
  Sangha(name: 'Kuakhia', district: 'Jajapur'),
  Sangha(name: 'Sambalpur', district: 'Sambalpur'),
  Sangha(name: 'Fasimal', district: 'Sambalpur'),
  Sangha(name: 'Burla', district: 'Sambalpur'),
  Sangha(name: 'Badagaon', district: 'Sundergarh'),
  Sangha(name: 'Rajgangpur', district: 'Sundergarh'),
  Sangha(name: 'Rourkela Town', district: 'Sundergarh'),
  Sangha(name: 'Rourkela Shaktinagar', district: 'Sundergarh'),
  Sangha(name: 'Balijodi', district: 'Sundergarh'),
  Sangha(name: 'Dengi Bhadi', district: 'Sundergarh'),
  Sangha(name: 'Keonjhar', district: 'Keonjhar'),
  Sangha(name: 'Joda', district: 'Keonjhar'),
  Sangha(name: 'Anandapur', district: 'Keonjhar'),
  Sangha(name: 'Atasahi', district: 'Keonjhar'),
  Sangha(name: 'Salabani', district: 'Keonjhar'),
  Sangha(name: 'Chhenapadi', district: 'Keonjhar'),
  Sangha(name: 'Boudh', district: 'Boudh'),
  Sangha(name: 'Delhi', state: 'Delhi'),
  Sangha(name: 'Kolkata', state: 'Kolkata'),
  Sangha(name: 'Hyderabad', state: 'Telengana'),
  Sangha(name: 'Mumbai', state: 'Maharastra'),
  Sangha(name: 'Pune', state: 'Maharastra'),
  Sangha(name: 'Chennai', state: 'Chennai'),
  Sangha(name: 'Surat', state: 'Gujrat'),
  Sangha(name: 'Raipur', state: 'Chhattisgarh'),
  Sangha(name: 'Karnataka', state: 'Karnataka'),
  Sangha(name: 'Tata', state: 'Jharkhand'),
  Sangha(name: 'Ranchi', state: 'Jharkhand'),
];
