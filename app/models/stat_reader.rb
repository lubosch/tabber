class StatReader

  def self.avg(file, column)
    merania = self.read(file, column)
    merania_fin = []
    (1...merania.count).each do |meranie|
      merania_fin << [meranie, merania[meranie][-1][0]]
    end
    binding.pry

    {-1 => merania_fin}
  end


  def self.read(file, column)

    merania=[]
    aktualne_meranie = []
    File.open(Rails.root + "app/assets/texts/" + file).each_line do |line|
      if /Meranie/.match line
        merania << aktualne_meranie
        aktualne_meranie = []
      else
        a = line.split ';'
        aktualne_meranie << [a[0].to_i, a[column].to_f]
      end


    end

    sum = 0
    merania_fin = []
    (1...merania.count).each do |meranie|
      merania_fin << [meranie, merania[meranie][-1][0]]
      sum+= merania[meranie][-1][0]
    end
    merania[-1] = merania_fin
    merania[-2] = sum/20.to_f

    merania
  end


end