import 'package:govimansala/pages/info_center/models/crop_info.dart';

final List<CropInfo> crops = [
  CropInfo(
    name: 'Rice',
    image: '../../../../assets/infocenter/paddy-rice.jpg',
    description: 'Staple crop grown in Yala and Maha seasons. Requires abundant water.',
    quickFacts: {
      'Season': 'Yala / Maha',
      'Soil': 'Clay / Loamy',
      'Irrigation': 'Flood / Controlled Drip',
    },
    schedule: [
      {'Sowing': 'Week 1 - Week 2'},
      {'Vegetative': 'Week 3 - Week 8'},
      {'Harvest': 'Week 9 - Week 12'},
    ],
    gettingStarted: [
      'Use certified seeds such as Bg 352 or Bg 366.',
      'Maintain 5–7 cm water depth during vegetative stage.',
      'Use organic compost before transplanting.',
    ],
    pests: [
      {'Brown Planthopper': 'Use resistant varieties and avoid over-fertilizing.'},
      {'Leaf Blast': 'Apply recommended fungicides early.'},
      {'Stem Borer': 'Use light traps and clean field after harvest.'},
    ],
  ),
  CropInfo(
    name: 'Maize',
    image: '../../../../assets/infocenter/maize.jpeg',
    description: 'Fast-growing cereal crop suited for both Yala and Maha seasons.',
    quickFacts: {
      'Season': 'Yala / Maha',
      'Soil': 'Well-drained loamy',
      'Irrigation': 'Drip / Sprinkler',
    },
    schedule: [
      {'Sowing': 'Week 1'},
      {'Vegetative': 'Week 2 - Week 6'},
      {'Harvest': 'Week 10 - Week 12'},
    ],
    gettingStarted: [
      'Plant hybrid varieties for better yield.',
      'Avoid waterlogging in early stages.',
      'Apply nitrogen fertilizer at knee-height stage.',
    ],
    pests: [
      {'Fall Armyworm': 'Use pheromone traps and maintain field hygiene.'},
      {'Stem Borer': 'Avoid continuous maize cultivation.'},
    ],
  ),
  CropInfo(
    name: 'Chili',
    image: '../../../../assets/infocenter/chilli.jpeg',
    description: 'Important cash crop requiring warm climate and moderate irrigation.',
    quickFacts: {
      'Season': 'Year-round',
      'Soil': 'Well-drained sandy loam',
      'Irrigation': 'Drip preferred',
    },
    schedule: [
      {'Sowing': 'Week 1 - Week 2'},
      {'Flowering': 'Week 6 - Week 8'},
      {'Harvest': 'Week 10 - Week 14'},
    ],
    gettingStarted: [
      'Use resistant varieties such as MI Hot or KA2.',
      'Avoid overwatering; ensure proper sunlight.',
      'Harvest when fruits turn bright red.',
    ],
    pests: [
      {'Thrips': 'Spray neem oil early morning.'},
      {'Anthracnose': 'Remove infected fruits and apply fungicide.'},
    ],
  ),
];
