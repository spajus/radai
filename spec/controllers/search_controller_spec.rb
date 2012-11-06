require 'spec_helper'

#55.7257 21.1715 Klaipeda,klaipedos raj.
#54.6749 25.2073 Vilnius,Lazdynai
#56.3109 22.348  Mazeikiai
#54.9283 23.9392 Kaunas, Eiguliai
#55.8897 21.2427 Kretinga
#54.7227 25.2432 Ukmerges g.Vilnius.
#55.7374 24.3703 Panevezys

describe SearchController do

  fixtures :service_types

  describe 'GET index' do

    after(:each) do
      Specialist.all.each { |s| s.destroy }
    end

    it 'should list all specialists' do
      3.times { FactoryGirl.create :specialist }
      get :index
      expect(assigns :results).to eq Specialist.desc.all
    end

    it 'should find a specialist nearby' do
      specialist = FactoryGirl.create :specialist
      specialist2 = FactoryGirl.create :specialist_klaipeda
      get :index, {
        search_radius: 5,
        specialist: {
          full_address: "Vilnius, Pilaite",
          latitude: 54.7043478,
          longitude: 25.1988444,
          extra_services_select: [ServiceType.first.id]
        }
      }
      expect(assigns :results).to eq [specialist]
    end

    it 'should sort results by range' do
      specialist1 = FactoryGirl.create :specialist
      specialist2 = FactoryGirl.create :specialist_panevezys
      specialist3 = FactoryGirl.create :specialist_kretinga
      get :index, {
        search_radius: 250,
        specialist: {
          full_address: "Klaipeda",
          latitude: 55.7108026,
          longitude: 21.1318065,
          extra_services_select: []
        }
      }
      expect(assigns :results).to eq [specialist3, specialist2]
    end

    it 'should sort results by primary service' do
      spec1 = FactoryGirl.create :specialist
      spec2 = FactoryGirl.create :specialist_klaipeda
      spec3 = FactoryGirl.create :specialist_panevezys
      spec4 = FactoryGirl.create :specialist_kretinga
      service1 = ServiceType.find_by_title("Griovimas")
      service2 = ServiceType.find_by_title("Elektra")
      service3 = ServiceType.find_by_title("Renovacija")

      spec1.title = "Right One"
      spec1.service_type_select = service1.id
      spec1.save
      spec2.title = "Right Two"
      spec2.service_type_select = service2.id
      spec2.extra_services_select = [service1.id]
      spec2.save
      spec3.title = "Right Three"
      spec3.service_type_select = service3.id
      spec3.extra_services_select = [service1.id, service2.id]
      spec3.save
      spec4.title = "Wrong One"
      spec4.service_type_select = service2.id
      spec4.save

      get :index, {
        search_radius: 300,
        specialist: {
          full_address: "Klaipeda",
          latitude: 55.7108026,
          longitude: 21.1318065,
          extra_services_select: [service1.id]
        }
      }
      expect(assigns :results).to eq [spec1, spec2, spec3]

    end

    it 'should not include duplicated results' do
      spec1 = FactoryGirl.create :specialist
      spec2 = FactoryGirl.create :specialist_klaipeda
      spec3 = FactoryGirl.create :specialist_panevezys
      spec4 = FactoryGirl.create :specialist_kretinga
      service1 = ServiceType.find_by_title("Griovimas")
      service2 = ServiceType.find_by_title("Elektra")
      service3 = ServiceType.find_by_title("Renovacija")

      spec1.title = "Right One"
      spec1.service_type_select = service1.id
      spec1.save
      spec2.title = "Right Two"
      spec2.service_type_select = service2.id
      spec2.extra_services_select = [service1.id]
      spec2.save
      spec3.title = "Right Three"
      spec3.service_type_select = service3.id
      spec3.extra_services_select = [service1.id, service2.id]
      spec3.save
      spec4.title = "Wrong One"
      spec4.service_type_select = service2.id
      spec4.save

      get :index, {
        search_radius: 300,
        specialist: {
          full_address: "Klaipeda",
          latitude: 55.7108026,
          longitude: 21.1318065,
          extra_services_select: [service1.id, service2.id, service3.id]
        }
      }
      assigns(:results).length.should eq 4

    end
  end
end

