// import 'package:flutter/material.dart';
import '../models/loan.dart';

List<Loan> loanList = [
  Loan(
    name: "Small Farmer Development Loan",
    description:
        "This loan supports small and medium-scale farmers to cultivate seasonal crops such as paddy, maize, and vegetables. It covers land preparation, seeds, fertilizer, and basic irrigation costs.",
    interestRate: "6.5% – 8.0% per annum (subsidized)",
    repaymentPeriod: "Up to 24 months",
    eligibility:
        "Available to registered farmers with valid cultivation permits or proof of land use. Applicants must have a minimum of one successful past harvest.",
    collateral:
        "Flexible – movable assets or guarantors accepted for small loan amounts.",
    image: "../../../../assets/infocenter/smallfarm.jpg",
  ),
  Loan(
    name: "Agricultural Equipment Purchase Loan",
    description:
        "Supports the purchase of essential farm machinery such as tractors, harvesters, and water pumps. Designed to help improve productivity through mechanization.",
    interestRate: "8.0% – 9.5% per annum",
    repaymentPeriod: "Up to 5 years",
    eligibility:
        "Farmers, cooperatives, or registered agribusinesses engaged in cultivation or processing. Must provide a quotation or invoice for the equipment.",
    collateral:
        "Equipment financed is typically used as collateral. Additional security may be requested for high-value machinery.",
    image: "../../../../assets/infocenter/farmeqip.jpg",
  ),
  Loan(
    name: "Irrigation System Upgrade Loan",
    description:
        "Provides financial assistance to farmers or groups installing or upgrading irrigation systems, including drip and sprinkler systems, to enhance water efficiency.",
    interestRate: "7.0% – 8.5% per annum",
    repaymentPeriod: "Up to 36 months",
    eligibility:
        "Open to individual farmers or farmer organizations cultivating at least 1 acre of land. Applicants must present an irrigation improvement plan or quotation.",
    collateral:
        "Land deeds or crop insurance policies may be accepted as collateral.",
    image: "../../../../assets/infocenter/irrigation.png",
  ),
  Loan(
    name: "Agro SME Development Loan",
    description:
        "Tailored for small and medium-scale agri-enterprises, covering capital expenses, expansion, or processing unit setup. Encourages agro-based entrepreneurship and value addition.",
    interestRate: "9.0% – 10.5% per annum",
    repaymentPeriod: "Up to 7 years",
    eligibility:
        "Available to registered SMEs in the agriculture or food-processing sector with business registration proof and basic financial statements.",
    collateral:
        "Fixed assets, business premises, or bank guarantees may be used as security.",
    image: "../../../../assets/infocenter/sme.jpg",
  ),
  Loan(
    name: "Youth Agripreneur Loan",
    description:
        "Encourages young individuals (18–40 years) to start or expand agriculture-related businesses. Focused on innovation and modern agricultural practices.",
    interestRate: "6.0% – 8.0% per annum (special youth rate)",
    repaymentPeriod: "Up to 4 years",
    eligibility:
        "Open to young entrepreneurs with business proposals or existing small-scale farms. Training or certification in agriculture is preferred.",
    collateral:
        "Guarantor or movable asset; flexible security for start-ups under special youth programs.",
    image: "../../../../assets/infocenter/youngfarm.jpg",
  ),
];
