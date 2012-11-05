
FactoryGirl.define do
  
  sequence(:name) { |n| "Vilnius #{n}" }
  sequence(:name_vilnius2) { |n| "Vilnius2 #{n}" }
  sequence(:name_panevezys) { |n| "Panevezys #{n}" }
  sequence(:name_kaunas) { |n| "Kaunas #{n}" }
  sequence(:name_klaipeda) { |n| "Klaipeda #{n}" }
  sequence(:name_mazeikiai) { |n| "Mazeikiai #{n}" }
  sequence(:name_kretinga) { |n| "Kretinga #{n}" }

  sequence :email do |n|
    "tomas.varaneckas+test#{n}@gmail.com"
  end

  factory :specialist do
    title { generate :name }
    about "Doing some stuff yo!"
    email { generate :email }
    phone "37061413645"
    full_address "Vilnius,Lazdynai"
    latitude 54.6749
    longitude 25.2073
    show_phone true
    show_email true 
    service_type_select ServiceType.first.id

    factory :specialist_vilnius2 do
      title { generate :name_vilnius2 }
      full_address "Ukmerges g.Vilnius."
      latitude 54.7227 
      longitude 25.2432 
    end
    factory :specialist_panevezys do
      title { generate :name_panevezys }
      full_address "Panevezys"
      latitude 55.7374 
      longitude 24.3703 
    end
    factory :specialist_kaunas do
      title { generate :name_kaunas }
      full_address "Kaunas, Eiguliai"
      latitude 54.9283 
      longitude 23.9392 
    end
    factory :specialist_klaipeda do
      title { generate :name_klaipeda }
      full_address "Klaipeda,klaipedos raj."
      latitude 55.7257
      longitude 21.1715  
    end
    factory :specialist_mazeikiai do
      title { generate :name_mazeikiai }
      full_address "Mazeikiai"
      latitude 56.3109 
      longitude 22.348   
    end
    factory :specialist_kretinga do
      title { generate :name_kretinga }
      full_address "Kretinga"
      latitude 55.8897 
      longitude 21.2427
    end
  end

end

