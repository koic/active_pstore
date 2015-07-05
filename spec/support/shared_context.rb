shared_context 'Rock stars on stage' do
  let(:randy_rhoads)  { Artist.new('Randy Rhoads', 'Ozzy Osbourne', 'guitar', Date.new(1956, 12, 6)) }
  let(:michael_amott) { Artist.new('Michael Amott', 'Arch Enemy', 'guitar', Date.new(1969, 7, 28)) }
  let(:don_airey)     { Artist.new('Don Airey', 'Ozzy Osbourne', 'keyboard', Date.new(1948, 6, 21)) }
  let(:zakk_wylde)    { Artist.new('Zakk Wylde', 'Ozzy Osbourne', 'guitar', Date.new(1948, 12, 3)) }

  before do
    Artist.establish_connection(database: '/tmp/active_pstore_test')

    Artist.destroy_all

    randy_rhoads.save
    michael_amott.save
    don_airey.save
    zakk_wylde.save
  end
end
