# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# WebplayerBasic.create(url: 'G', embed_code: '<iframe></iframe>', width: '100%', height: '700px')
# AgentInfo.create(first_name: 'test1', last_name: 'test2', phone: '123')
# DisplayOption.create(show_google45_imagery: false, show_exterior_walkin: false, show_detach_unit: false)
# RestrictOption.create(email: false, email_confirmation: false, name:false, message: false, phone: false,
#                       agent_approval: false, send_inquire: false, walkintour: false, google45_imagery: false,
#                       exterior_walkin: false, detach_unit: false)
=begin
State.create([
   { name: 'Alabama', abbreviation: 'AL' },
   { name: 'Alaska', abbreviation: 'AK' },
   { name: 'American Samoa', abbreviation: 'AS' },
   { name: 'Arizona', abbreviation: 'AZ' },
   { name: 'Arkansas', abbreviation: 'AR' },
   { name: 'California', abbreviation: 'CA' },
   { name: 'Colorado', abbreviation: 'CO' },
   { name: 'Connecticut', abbreviation: 'CT' },
   { name: 'Delaware', abbreviation: 'DE' },
   { name: 'District Of Columbia', abbreviation: 'DC' },
   { name: 'Federated States Of Micronesia', abbreviation: 'FM' },
   { name: 'Florida', abbreviation: 'FL' },
   { name: 'Georgia', abbreviation: 'GA' },
   { name: 'Guam', abbreviation: 'GU' },
   { name: 'Hawaii', abbreviation: 'HI' },
   { name: 'Idaho', abbreviation: 'ID' },
   { name: 'Illinois', abbreviation: 'IL' },
   { name: 'Indiana', abbreviation: 'IN' },
   { name: 'Iowa', abbreviation: 'IA' },
   { name: 'Kansas', abbreviation: 'KS' },
   { name: 'Kentucky', abbreviation: 'KY' },
   { name: 'Louisiana', abbreviation: 'LA' },
   { name: 'Maine', abbreviation: 'ME' },
   { name: 'Marshall Islands', abbreviation: 'MH' },
   { name: 'Maryland', abbreviation: 'MD' },
   { name: 'Massachusetts', abbreviation: 'MA'},
   { name: 'Michigan', abbreviation: 'MI' },
   { name: 'Minnesota', abbreviation: 'MN' },
   { name: 'Mississippi', abbreviation: 'MS' },
   { name: 'Missouri', abbreviation: 'MO' },
   { name: 'Montana', abbreviation: 'MT' },
   { name: 'Nebraska', abbreviation: 'NE' },
   { name: 'Nevada', abbreviation: 'NV' },
   { name: 'New Hampshire', abbreviation: 'NH' },
   { name: 'New Jersey', abbreviation: 'NJ' },
   { name: 'New Mexico', abbreviation: 'NM' },
   { name: 'New York', abbreviation: 'NY' },
   { name: 'North Carolina', abbreviation: 'NC' },
   { name: 'North Dakota', abbreviation: 'ND' },
   { name: 'Northern Mariana Islands', abbreviation: 'MP' },
   { name: 'Ohio', abbreviation: 'OH' },
   { name: 'Oklahoma', abbreviation: 'OK' },
   { name: 'Oregon', abbreviation: 'OR' },
   { name: 'Palau', abbreviation: 'PW' },
   { name: 'Pennsylvania', abbreviation: 'PA' },
   { name: 'Puerto Rico', abbreviation: 'PR' },
   { name: 'Rhode Island', abbreviation: 'RI' },
   { name: 'South Carolina', abbreviation: 'SC' },
   { name: 'South Dakota', abbreviation: 'SD' },
   { name: 'Tennessee', abbreviation: 'TN' },
   { name: 'Texas', abbreviation: 'TX' },
   { name: 'Utah', abbreviation: 'UT' },
   { name: 'Vermont', abbreviation: 'VT' },
   { name: 'Virgin Islands', abbreviation: 'VI' },
   { name: 'Virginia', abbreviation: 'VA' },
   { name: 'Washington', abbreviation: 'WA' },
   { name: 'West Virginia', abbreviation: 'WV' },
   { name: 'Wisconsin', abbreviation: 'WI' },
   { name: 'Wyoming', abbreviation: 'WY' }
])
Country.create([
     {name: 'United States'}
 ])
=end

TourBranding.create([
   {tour_id: 1},
   {tour_id: 2},
   {tour_id: 3},
   {tour_id: 4},
   {tour_id: 5},
   {tour_id: 11},
   {tour_id: 14},
   {tour_id: 20},
   {tour_id: 21}]
)