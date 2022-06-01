//
//  ISOCountries.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//

import Foundation

//"ATG" : "Antigua și Barbuda",
//"BHR" : "Bahrain",
//"BLR" : "Belarus",
//"BTN" : "Bhutan",
//"BFA" : "Burkina Faso",
//"CPV" : "Republica Capului Verde",
//"CAF" : "Republica Centrafricană",
//"COM" : "Comore",
//"COD" : "Republica Democrată Congo",
//"SWZ" : "Eswatini",
//"FJI" : "Fiji",
//"FRA" : "Franța",
//"KGZ" : "Kârgâzstan",
//"MDV" : "Maldive",
//"MCO" : "Monaco",
//"MNE" : "Muntenegru",
//"KNA" : "Sfântul Kitts și Nevis",
//"KNA" : "Sfântul Kitts și Nevis",
//"VCT" : "Sfântul Vincent și Grenadine",
//"STP" : "Sao Tome și Principe",
//"SRB" : "Serbia",
//"SSD" : "Sudanul de Sud",
//"SYR" : "Siria",
//"TLS" : "Timorul de Est",
//"TTO" : "Trinidad și Tobago",

let roISOCountries: [String : String] = [
    "AFG" : "Afganistan",
    "ALB" : "Albania",
    "DZA" : "Algeria",
    "AND" : "Andorra",
    "AGO" : "Angola",
    "ARG" : "Argentina",
    "ARM" : "Armenia",
    "AUS" : "Australia",
    "AUT" : "Austria",
    "AZE" : "Azerbaidjan",
    "BHS" : "Bahamas",
    "BGD" : "Bangladesh",
    "BRB" : "Barbados",
    "BEL" : "Belgia",
    "BLZ" : "Belize",
    "BEN" : "Benin",
    "BOL" : "Bolivia",
    "BIH" : "Bosnia și Herțegovina",
    "BWA" : "Botswana",
    "BRA" : "Brazilia",
    "BRN" : "Brunei",
    "BGR" : "Bulgaria",
    "BDI" : "Burundi",
    "KHM" : "Cambodgia",
    "CMR" : "Camerun",
    "CAN" : "Canada",
    "TCD" : "Ciad",
    "CHL" : "Chile",
    "CHN" : "Republica Populară Chineză",
    "COL" : "Columbia",
    "COG" : "Congo",
    "CRI" : "Costa Rica",
    "CIV" : "Coasta de Fildeș",
    "HRV" : "Croația",
    "CUB" : "Cuba",
    "CYP" : "Cipru",
    "CZE" : "Cehia",
    "DNK" : "Danemarca",
    "DJI" : "Djibouti",
    "DMA" : "Dominica",
    "DOM" : "Republica Dominicană",
    "ECU" : "Ecuador",
    "EGY" : "Egipt",
    "SLV" : "El Salvador",
    "GNQ" : "Guineea Ecuatorială",
    "ERI" : "Eritreea",
    "EST" : "Estonia",
    "ETH" : "Etiopia",
    "FIN" : "Finlanda",
    "GAB" : "Gabon",
    "GMB" : "Gambia",
    "GEO" : "Georgia",
    "DEU" : "Germania",
    "GHA" : "Ghana",
    "GRC" : "Grecia",
    "GRD" : "Grenada",
    "GTM" : "Guatemala",
    "GIN" : "Guineea",
    "GNB" : "Guineea-Bissau",
    "GUY" : "Guyana",
    "HTI" : "Haiti",
    "HND" : "Honduras",
    "HUN" : "Ungaria",
    "ISL" : "Islanda",
    "IND" : "India",
    "IDN" : "Indonezia",
    "IRN" : "Iran",
    "IRQ" : "Irak",
    "IRL" : "Irlanda",
    "ISR" : "Israel",
    "ITA" : "Italia",
    "JAM" : "Jamaica",
    "JPN" : "Japonia",
    "JOR" : "Iordania",
    "KAZ" : "Kazahstan",
    "KEN" : "Kenya",
    "KIR" : "Kiribati",
    "KOR" : "Coreea de Sud",
    "KWT" : "Kuweit",
    "LAO" : "Laos",
    "LVA" : "Letonia",
    "LBN" : "Liban",
    "LSO" : "Lesotho",
    "LBR" : "Liberia",
    "LBY" : "Libia",
    "LIE" : "Liechtenstein",
    "LTU" : "Lituania",
    "LUX" : "Luxemburg",
    "MKD" : "Republica Macedonia",
    "MDG" : "Madagascar",
    "MWI" : "Malawi",
    "MYS" : "Malaezia",
    "MLI" : "Mali",
    "MLT" : "Malta",
    "MHL" : "Insulele Marshall",
    "MRT" : "Mauritania",
    "MUS" : "Mauritius",
    "MEX" : "Mexic",
    "FSM" : "Micronezia",
    "MDA" : "Republica Moldova",
    "MNG" : "Mongolia",
    "MAR" : "Maroc",
    "MOZ" : "Mozambic",
    "MMR" : "Myanmar",
    "NAM" : "Namibia",
    "NRU" : "Nauru",
    "NPL" : "Nepal",
    "NLD" : "Olanda",
    "NZL" : "Noua Zeelandă",
    "NIC" : "Nicaragua",
    "NER" : "Niger",
    "NGA" : "Nigeria",
    "NOR" : "Norvegia",
    "OMN" : "Oman",
    "PAK" : "Pakistan",
    "PLW" : "Palau",
    "PAN" : "Panama",
    "PNG" : "Papua Noua Guinee",
    "PRY" : "Paraguay",
    "PER" : "Peru",
    "PHL" : "Filipine",
    "POL" : "Polonia",
    "PRT" : "Portugalia",
    "QAT" : "Qatar",
    "ROU" : "România",
    "RUS" : "Rusia",
    "RWA" : "Rwanda",
    "LCA" : "Saint Lucia",
    "WSM" : "Samoa",
    "SMR" : "San Marino",
    "SAU" : "Arabia Saudită",
    "SEN" : "Senegal",
    "SYC" : "Seychelles",
    "SLE" : "Sierra Leone",
    "SGP" : "Singapore",
    "SVK" : "Slovacia",
    "SVN" : "Slovenia",
    "SLB" : "Insulele Solomon",
    "SOM" : "Somalia",
    "ZAF" : "Africa de Sud",
    "ESP" : "Spania",
    "LKA" : "Sri Lanka",
    "SDN" : "Sudan",
    "SUR" : "Surinam",
    "SWE" : "Suedia",
    "CHE" : "Elveția",
    "TJK" : "Tadjikistan",
    "TZA" : "Tanzania",
    "THA" : "Thailanda",
    "TGO" : "Togo",
    "TON" : "Tonga",
    "TUN" : "Tunisia",
    "TUR" : "Turcia",
    "TKM" : "Turkmenistan",
    "TUV" : "Tuvalu",
    "UGA" : "Uganda",
    "UKR" : "Ucraina",
    "ARE" : "Emiratele Arabe Unite",
    "GBR" : "Regatul Unit",
    "USA" : "Statele Unite ale Americii",
    "URY" : "Uruguay",
    "UZB" : "Uzbekistan",
    "VUT" : "Vanuatu",
    "VEN" : "Venezuela",
    "VNM" : "Vietnam",
    "YEM" : "Yemen",
    "ZMB" : "Zambia",
    "ZWE" : "Zimbabwe"
]

let enISOCountries: [String: String] = [
    "AFG" : "Afghanistan",
    "ALB" : "Albania",
    "DZA" : "Algeria",
    "AND" : "Andorra",
    "AGO" : "Angola",
    "ARG" : "Argentina",
    "ARM" : "Armenia",
    "AUS" : "Australia",
    "AUT" : "Austria",
    "AZE" : "Azerbaijan",
    "BHS" : "Bahamas",
    "BGD" : "Bangladesh",
    "BRB" : "Barbados",
    "BEL" : "Belgium",
    "BLZ" : "Belize",
    "BEN" : "Benin",
    "BOL" : "Bolivia",
    "BIH" : "Bosnia and Herzegovina",
    "BWA" : "Botswana",
    "BRA" : "Brazil",
    "BRN" : "Brunei Darussalam",
    "BGR" : "Bulgaria",
    "BDI" : "Burundi",
    "KHM" : "Cambodia",
    "CMR" : "Cameroon",
    "CAN" : "Canada",
    "TCD" : "Chad",
    "CHL" : "Chile",
    "CHN" : "China",
    "COL" : "Colombia",
    "COG" : "Congo",
    "CRI" : "Costa Rica",
    "CIV" : "Côte d'Ivoire",
    "HRV" : "Croatia",
    "CUB" : "Cuba",
    "CYP" : "Cyprus",
    "CZE" : "Czech Republic",
    "DNK" : "Denmark",
    "DJI" : "Djibouti",
    "DMA" : "Dominica",
    "DOM" : "Dominican Republic",
    "ECU" : "Ecuador",
    "EGY" : "Egypt",
    "SLV" : "El Salvador",
    "GNQ" : "Equatorial Guinea",
    "ERI" : "Eritrea",
    "EST" : "Estonia",
    "ETH" : "Ethiopia",
    "FIN" : "Finland",
    "GAB" : "Gabon",
    "GMB" : "Gambia",
    "GEO" : "Georgia",
    "DEU" : "Germany",
    "GHA" : "Ghana",
    "GRC" : "Greece",
    "GRD" : "Grenada",
    "GTM" : "Guatemala",
    "GIN" : "Guinea",
    "GNB" : "Guinea-Bissau",
    "GUY" : "Guyana",
    "HTI" : "Haiti",
    "HND" : "Honduras",
    "HUN" : "Hungary",
    "ISL" : "Iceland",
    "IND" : "India",
    "IDN" : "Indonesia",
    "IRN" : "Iran",
    "IRQ" : "Iraq",
    "IRL" : "Ireland",
    "ISR" : "Israel",
    "ITA" : "Italy",
    "JAM" : "Jamaica",
    "JPN" : "Japan",
    "JOR" : "Jordan",
    "KAZ" : "Kazakhstan",
    "KEN" : "Kenya",
    "KIR" : "Kiribati",
    "KWT" : "Kuwait",
    "LAO" : "Lao Peoples Democratic Republic",
    "LVA" : "Latvia",
    "LBN" : "Lebanon",
    "LSO" : "Lesotho",
    "LBR" : "Liberia",
    "LBY" : "Libya",
    "LIE" : "Liechtenstein",
    "LTU" : "Lithuania",
    "LUX" : "Luxembourg",
    "MDG" : "Madagascar",
    "MWI" : "Malawi",
    "MYS" : "Malaysia",
    "MLI" : "Mali",
    "MLT" : "Malta",
    "MHL" : "Marshall Islands",
    "MRT" : "Mauritania",
    "MUS" : "Mauritius",
    "MEX" : "Mexico",
    "FSM" : "Micronesia (Federated States of)",
    "MNG" : "Mongolia",
    "MAR" : "Morocco",
    "MOZ" : "Mozambique",
    "MMR" : "Myanmar",
    "NAM" : "Namibia",
    "NRU" : "Nauru",
    "NPL" : "Nepal",
    "NLD" : "Netherlands",
    "NZL" : "New Zealand",
    "NIC" : "Nicaragua",
    "NER" : "Niger",
    "NGA" : "Nigeria",
    "NOR" : "Norway",
    "OMN" : "Oman",
    "PAK" : "Pakistan",
    "PLW" : "Palau",
    "PAN" : "Panama",
    "PNG" : "Papua New Guinea",
    "PRY" : "Paraguay",
    "PER" : "Peru",
    "PHL" : "Philippines",
    "POL" : "Poland",
    "PRT" : "Portugal",
    "QAT" : "Qatar",
    "KOR" : "Republic of Korea",
    "MDA" : "Republic of Moldova",
    "ROU" : "Romania",
    "RUS" : "Russian Federation",
    "RWA" : "Rwanda",
    "LCA" : "Saint Lucia",
    "WSM" : "Samoa",
    "SMR" : "San Marino",
    "SAU" : "Saudi Arabia",
    "SEN" : "Senegal",
    "SYC" : "Seychelles",
    "SLE" : "Sierra Leone",
    "SGP" : "Singapore",
    "SVK" : "Slovakia",
    "SVN" : "Slovenia",
    "SLB" : "Solomon Islands",
    "SOM" : "Somalia",
    "ZAF" : "South Africa",
    "ESP" : "Spain",
    "LKA" : "Sri Lanka",
    "SDN" : "Sudan",
    "SUR" : "Suriname",
    "SWE" : "Sweden",
    "CHE" : "Switzerland",
    "TJK" : "Tajikistan",
    "THA" : "Thailand",
    "MKD" : "The former Yugoslav Republic of Macedonia",
    "TGO" : "Togo",
    "TON" : "Tonga",
    "TUN" : "Tunisia",
    "TUR" : "Turkey",
    "TKM" : "Turkmenistan",
    "TUV" : "Tuvalu",
    "UGA" : "Uganda",
    "UKR" : "Ukraine",
    "ARE" : "United Arab Emirates",
    "GBR" : "United Kingdom",
    "TZA" : "United Republic of Tanzania",
    "USA" : "United States of America",
    "URY" : "Uruguay",
    "UZB" : "Uzbekistan",
    "VUT" : "Vanuatu",
    "VEN" : "Venezuela (Bolivarian Republic of)",
    "VNM" : "Viet Nam",
    "YEM" : "Yemen",
    "ZMB" : "Zambia",
    "ZWE" : "Zimbabwe",
]

let ISO3ToISO2: [String: String] = [
    "AFG" : "AF",
    "ALA" : "AX",
    "ALB" : "AL",
    "DZA" : "DZ",
    "ASM" : "AS",
    "AND" : "AD",
    "AGO" : "AO",
    "AIA" : "AI",
    "ATA" : "AQ",
    "ATG" : "AG",
    "ARG" : "AR",
    "ARM" : "AM",
    "ABW" : "AW",
    "AUS" : "AU",
    "AUT" : "AT",
    "AZE" : "AZ",
    "BHS" : "BS",
    "BHR" : "BH",
    "BGD" : "BD",
    "BRB" : "BB",
    "BLR" : "BY",
    "BEL" : "BE",
    "BLZ" : "BZ",
    "BEN" : "BJ",
    "BMU" : "BM",
    "BTN" : "BT",
    "BOL" : "BO",
    "BIH" : "BA",
    "BWA" : "BW",
    "BVT" : "BV",
    "BRA" : "BR",
    "VGB" : "VG",
    "IOT" : "IO",
    "BRN" : "BN",
    "BGR" : "BG",
    "BFA" : "BF",
    "BDI" : "BI",
    "KHM" : "KH",
    "CMR" : "CM",
    "CAN" : "CA",
    "CPV" : "CV",
    "CYM" : "KY",
    "CAF" : "CF",
    "TCD" : "TD",
    "CHL" : "CL",
    "CHN" : "CN",
    "HKG" : "HK",
    "MAC" : "MO",
    "CXR" : "CX",
    "CCK" : "CC",
    "COL" : "CO",
    "COM" : "KM",
    "COG" : "CG",
    "COD" : "CD",
    "COK" : "CK",
    "CRI" : "CR",
    "CIV" : "CI",
    "HRV" : "HR",
    "CUB" : "CU",
    "CYP" : "CY",
    "CZE" : "CZ",
    "DNK" : "DK",
    "DJI" : "DJ",
    "DMA" : "DM",
    "DOM" : "DO",
    "ECU" : "EC",
    "EGY" : "EG",
    "SLV" : "SV",
    "GNQ" : "GQ",
    "ERI" : "ER",
    "EST" : "EE",
    "ETH" : "ET",
    "FLK" : "FK",
    "FRO" : "FO",
    "FJI" : "FJ",
    "FIN" : "FI",
    "FRA" : "FR",
    "GUF" : "GF",
    "PYF" : "PF",
    "ATF" : "TF",
    "GAB" : "GA",
    "GMB" : "GM",
    "GEO" : "GE",
    "DEU" : "DE",
    "GHA" : "GH",
    "GIB" : "GI",
    "GRC" : "GR",
    "GRL" : "GL",
    "GRD" : "GD",
    "GLP" : "GP",
    "GUM" : "GU",
    "GTM" : "GT",
    "GGY" : "GG",
    "GIN" : "GN",
    "GNB" : "GW",
    "GUY" : "GY",
    "HTI" : "HT",
    "HMD" : "HM",
    "VAT" : "VA",
    "HND" : "HN",
    "HUN" : "HU",
    "ISL" : "IS",
    "IND" : "IN",
    "IDN" : "ID",
    "IRN" : "IR",
    "IRQ" : "IQ",
    "IRL" : "IE",
    "IMN" : "IM",
    "ISR" : "IL",
    "ITA" : "IT",
    "JAM" : "JM",
    "JPN" : "JP",
    "JEY" : "JE",
    "JOR" : "JO",
    "KAZ" : "KZ",
    "KEN" : "KE",
    "KIR" : "KI",
    "PRK" : "KP",
    "KOR" : "KR",
    "KWT" : "KW",
    "KGZ" : "KG",
    "LAO" : "LA",
    "LVA" : "LV",
    "LBN" : "LB",
    "LSO" : "LS",
    "LBR" : "LR",
    "LBY" : "LY",
    "LIE" : "LI",
    "LTU" : "LT",
    "LUX" : "LU",
    "MKD" : "MK",
    "MDG" : "MG",
    "MWI" : "MW",
    "MYS" : "MY",
    "MDV" : "MV",
    "MLI" : "ML",
    "MLT" : "MT",
    "MHL" : "MH",
    "MTQ" : "MQ",
    "MRT" : "MR",
    "MUS" : "MU",
    "MYT" : "YT",
    "MEX" : "MX",
    "FSM" : "FM",
    "MDA" : "MD",
    "MCO" : "MC",
    "MNG" : "MN",
    "MNE" : "ME",
    "MSR" : "MS",
    "MAR" : "MA",
    "MOZ" : "MZ",
    "MMR" : "MM",
    "NAM" : "NA",
    "NRU" : "NR",
    "NPL" : "NP",
    "NLD" : "NL",
    "ANT" : "AN",
    "NCL" : "NC",
    "NZL" : "NZ",
    "NIC" : "NI",
    "NER" : "NE",
    "NGA" : "NG",
    "NIU" : "NU",
    "NFK" : "NF",
    "MNP" : "MP",
    "NOR" : "NO",
    "OMN" : "OM",
    "PAK" : "PK",
    "PLW" : "PW",
    "PSE" : "PS",
    "PAN" : "PA",
    "PNG" : "PG",
    "PRY" : "PY",
    "PER" : "PE",
    "PHL" : "PH",
    "PCN" : "PN",
    "POL" : "PL",
    "PRT" : "PT",
    "PRI" : "PR",
    "QAT" : "QA",
    "REU" : "RE",
    "ROU" : "RO",
    "RUS" : "RU",
    "RWA" : "RW",
    "BLM" : "BL",
    "SHN" : "SH",
    "KNA" : "KN",
    "LCA" : "LC",
    "MAF" : "MF",
    "SPM" : "PM",
    "VCT" : "VC",
    "WSM" : "WS",
    "SMR" : "SM",
    "STP" : "ST",
    "SAU" : "SA",
    "SEN" : "SN",
    "SRB" : "RS",
    "SYC" : "SC",
    "SLE" : "SL",
    "SGP" : "SG",
    "SVK" : "SK",
    "SVN" : "SI",
    "SLB" : "SB",
    "SOM" : "SO",
    "ZAF" : "ZA",
    "SGS" : "GS",
    "SSD" : "SS",
    "ESP" : "ES",
    "LKA" : "LK",
    "SDN" : "SD",
    "SUR" : "SR",
    "SJM" : "SJ",
    "SWZ" : "SZ",
    "SWE" : "SE",
    "CHE" : "CH",
    "SYR" : "SY",
    "TWN" : "TW",
    "TJK" : "TJ",
    "TZA" : "TZ",
    "THA" : "TH",
    "TLS" : "TL",
    "TGO" : "TG",
    "TKL" : "TK",
    "TON" : "TO",
    "TTO" : "TT",
    "TUN" : "TN",
    "TUR" : "TR",
    "TKM" : "TM",
    "TCA" : "TC",
    "TUV" : "TV",
    "UGA" : "UG",
    "UKR" : "UA",
    "ARE" : "AE",
    "GBR" : "GB",
    "USA" : "US",
    "UMI" : "UM",
    "URY" : "UY",
    "UZB" : "UZ",
    "VUT" : "VU",
    "VEN" : "VE",
    "VNM" : "VN",
    "VIR" : "VI",
    "WLF" : "WF",
    "ESH" : "EH",
    "YEM" : "YE",
    "ZMB" : "ZM",
    "ZWE" : "ZW",
    "XKX" : "XK"
]

let roContients: [String : String] = [
    "Asia" : "Asia",
    "Europe" : "Europa",
    "Africa" : "Africa",
    "North America" : "America de Nord",
    "Oceania" : "Oceania",
    "South America" : "America de Sud",
    "Antarctica" : "Antarctica"
]

func countryToISO(country: String, dictionary: [String : String]) -> String?{
    for (key, value) in dictionary {
        if value == country{
            return key
        }
    }
    
    return nil
}
