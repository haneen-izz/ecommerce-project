class ImportCsvJob < ApplicationJob

    def perform(file_path)
      csv_text = File.read(file_path)
      csv = CSV.parse(csv_text, headers: true)      
      @total_rows = csv.count { |row| row.any? { |cell| cell.present? } }
      @processed_records = 0
  
      csv.each do |row|
        @tot = @total_rows
        @processed_records += 1
  
        product_hash = {}
        unless row['ID'] == nil
          prod = Product.find_by(id: row['ID'])
          product_hash[:id] = row['ID']
          product_hash[:name] = row['Name']
          product_hash[:description] = row['Description']
          product_hash[:production_date] = row['Production Date']
          product_hash[:expiration_date] = row['Expiration Date']
          product_hash[:price] = row['Price']
          product_hash[:stock_quantity] = row['Stock Quantity']
          product_hash[:store_id] = row['Store Id']
          product_hash[:url] = row['Url']
          
          @progress = (@processed_records.to_f / @tot.to_f) * 100
          ActionCable.server.broadcast 'AlertsChannel' ,@progress
           
  
        if prod.present?
             prod.update(product_hash)
        else 
          Product.create!(product_hash)
          
        end
      end
    end
    
  end
end

