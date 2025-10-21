// import 'package:flutter/material.dart';
import '../models/gov_policy.dart';


final List<Policy> policyList = [
  // ───────────────────── SUBSIDIES ─────────────────────
  const Policy(
    title: 'Fertilizer Subsidy Program',
    summary:
        'Government support for paddy and other major crops through reduced fertilizer prices.',
    date: '2024-04-15',
    category: 'Subsidies',
    details:
        'The Fertilizer Subsidy Program helps farmers reduce production costs by providing chemical and organic fertilizers at subsidized rates. '
        'Eligible registered farmers can apply through local Agrarian Service Centers. The subsidy covers up to 50–75% of fertilizer cost.\n\n'
        'Key facts:\n• Managed by the Ministry of Agriculture\n• Focus on paddy, maize, and tea sectors\n• Payment through farmer accounts at state banks.',
  ),

  const Policy(
    title: 'Seed and Planting Material Assistance Scheme',
    summary:
        'Support for certified seed and planting material to promote quality crop production.',
    date: '2023-12-01',
    category: 'Subsidies',
    details:
        'This scheme encourages farmers to use certified seeds by offering a 40% price reduction on selected crop varieties. '
        'It also funds nurseries and local seed producers to ensure timely supply.\n\n'
        'Key facts:\n• Managed by Department of Agriculture\n• Focus on maize, vegetables, and pulses\n• Registration required via Divisional Agrarian Office.',
  ),

  // ───────────────────── LAND ─────────────────────
  const Policy(
    title: 'Agricultural Land Use Regulation 2024',
    summary:
        'Updated guidelines to promote efficient and sustainable use of agricultural land.',
    date: '2024-01-20',
    category: 'Land',
    details:
        'The regulation encourages the conversion of underutilized state and private lands for food and export crop cultivation. '
        'It also includes new zoning rules to prevent soil erosion and protect sensitive ecosystems.\n\n'
        'Key facts:\n• Overseen by Land Use Policy Planning Department\n• Allows land consolidation for commercial farming\n• Promotes organic and eco-friendly practices.',
  ),

  const Policy(
    title: 'National Land Bank Initiative',
    summary:
        'Database of unused and underused government lands available for agriculture investment.',
    date: '2023-11-10',
    category: 'Land',
    details:
        'The National Land Bank provides an updated digital platform listing government lands suitable for agriculture. '
        'It aims to attract local and foreign investors for commercial cultivation while maintaining environmental safeguards.\n\n'
        'Key facts:\n• Managed by Ministry of Lands\n• Transparent online allocation process\n• Priority for youth and women entrepreneurs.',
  ),

  // ───────────────────── IRRIGATION ─────────────────────
  const Policy(
    title: 'Irrigation Modernization Project',
    summary:
        'A long-term plan to upgrade irrigation infrastructure and improve water efficiency.',
    date: '2024-03-12',
    category: 'Irrigation',
    details:
        'This project upgrades canals, reservoirs, and small-scale irrigation systems to ensure efficient water management. '
        'It promotes micro-irrigation and solar-powered pumping systems for rural farmers.\n\n'
        'Key facts:\n• Funded by the World Bank and Government of Sri Lanka\n• Targets North Central, Eastern, and Uva provinces\n• Includes training for farmer organizations.',
  ),

  const Policy(
    title: 'Climate-Resilient Agriculture and Irrigation Plan',
    summary:
        'Supports farmers to adapt to changing rainfall patterns and water shortages.',
    date: '2024-02-05',
    category: 'Irrigation',
    details:
        'This plan introduces climate-smart irrigation practices, including rainwater harvesting and drip irrigation systems. '
        'It promotes crop diversification and sustainable use of groundwater.\n\n'
        'Key facts:\n• Managed by Ministry of Irrigation\n• In partnership with FAO and UNDP\n• Pilot projects in dry-zone districts.',
  ),

  // ───────────────────── INSURANCE ─────────────────────
  const Policy(
    title: 'Agricultural Crop Insurance Scheme',
    summary:
        'Insurance coverage for crop losses due to floods, droughts, or pests.',
    date: '2024-01-05',
    category: 'Insurance',
    details:
        'Implemented through the Agricultural and Agrarian Insurance Board, this scheme compensates farmers for losses caused by natural disasters. '
        'Premiums are subsidized for smallholders.\n\n'
        'Key facts:\n• Covers paddy, maize, tea, coconut, and vegetables\n• Claims processed through Agrarian Service Centers\n• Premiums as low as Rs. 250 per acre.',
  ),

  const Policy(
    title: 'Livestock and Dairy Insurance Program',
    summary:
        'Coverage for dairy farmers against animal deaths and disease outbreaks.',
    date: '2023-09-18',
    category: 'Insurance',
    details:
        'This program provides financial protection to small and medium dairy farmers against losses from livestock diseases or accidents. '
        'It also promotes improved animal health practices.\n\n'
        'Key facts:\n• Managed by the Department of Animal Production and Health\n• Covers cattle, goats, and buffaloes\n• Available through People’s Insurance and AICL.',
  ),
];
