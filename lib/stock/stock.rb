require "nokogiri"
require "rest_client"
require "debugger"

class Stock

	OPEN_TIME = Time.new(Time.now.year, Time.now.month, Time.now.day, 9, 30, 0)
	CLOSE_TIME = Time.new(Time.now.year, Time.now.month, Time.now.day, 16, 0, 0)

	def initialize ticker
		@ticker = ticker		
	end

	def self.find ticker
		self.new(ticker) 
	end

	COLUMNS = {
		closing_price: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: "#yfs_l84_TICKER_DOWNCASE"},
		close: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: "#yfs_l84_TICKER_DOWNCASE"},
		previous_closing_price: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[1]/td'},
		prev_close: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[1]/td'},
		opening_price: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[2]/td'},
		open: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[2]/td'},
		one_year_target_estimate: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[5]/td'},
		beta: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table1"]/tbody/tr[6]/td'},
		average_volume: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[4]/td'},
		avg_vol_3m: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[4]/td'},
		price_earnings_ratio: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[6]/td'},
		pe_ratio: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[6]/td'},
		pe: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[6]/td'},
		earnings_per_share: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[7]/td'},
		eps: {link: "http://finance.yahoo.com/q?s=TICKER", xpath: '//*[@id="table2"]/tbody/tr[7]/td'},
	}
	
	def method_missing method, *args, &block
		method = method.downcase.to_sym	
		if COLUMNS.keys.include? method
			attributes = COLUMNS[method]
			link = attributes[:link].gsub('TICKER', @ticker)
			xpath = attributes[:xpath].gsub('TICKER_DOWNCASE', @ticker.downcase)
			debugger
			doc = Nokogiri::HTML(RestClient.get(link))
			price = doc.search(xpath).children[0].to_s.to_f
		end
	end

	# returns a float with the price (takes into account after-hours price)
	def price
		link = "http://finance.yahoo.com/q?s=#{@ticker}"
		doc = Nokogiri::HTML(RestClient.get(link))

		if Time.now.between?(OPEN_TIME, CLOSE_TIME)
			xpath = "#yfs_l84_#{@ticker.downcase}"
		else
			xpath = "#yfs_l86_#{@ticker.downcase}"
		end

		price = doc.search(xpath).children[0].to_s.to_f
	end

	def next_earnings_date
	end

	def days_range
	end

	def years_range
	end

	def market_cap
	end

end