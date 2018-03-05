require 'json'

class Calculator

  def initialize(amount)
    # TODO: 解决非数字的情况
    @amount = amount.to_f
  end

  def fk_it
    @result = []
    @result << laodong
    @result << laowu
    @items = @result.collect{|i| gen_item(i)}
    JSON.generate({items: @items})
  end

  private

  def gen_item(item)
    type = item[:type]
    balance = item[:balance].round(2)
    tax = item[:tax].round(2)
    rate = item[:rate]
    title = "#{type} 税后:#{balance} 税额:#{tax} 税率:#{rate}"
    {
      title: title,
      subtitle: item[:info],
      icon: "Info.icns",
      arg: title,
      text: {
        copy: title,
        largetype: title
      }
    }
  end

  def laowu
    # 劳务报酬
    if @amount < 800
      rate = 0.2
      tax = 0
    elsif @amount < 4000
      rate = 0.2
      tax = (@amount - 800) * rate
    elsif @amount < 20000
      rate = 0.2
      tax = @amount * 0.8 * rate
    elsif @amount < 50000
      rate = 0.3
      tax = @amount * 0.8 * rate - 2000
    else
      rate = 0.4
      tax = @amount * 0.8 * rate - 7000
    end

    {
      type: '劳务报酬',
      balance: @amount - tax,
      tax: tax,
      rate: rate,
      info: '指个人独立从事各种非雇佣的各种劳务所取得的所得'
    }
  end

  def laodong
    # 工资薪金
    num = @amount - 3500
    if num < 0
      rate = 0
      tax = 0
    elsif num < 1455
      rate = 0.03
      tax = num * rate
    elsif num < 4155
      rate = 0.1
      tax = num * rate - 105
    elsif num < 7755
      rate = 0.2
      tax = num * rate - 555
    elsif num < 27255
      rate = 0.25
      tax = num * rate - 1005
    elsif num < 41255
      rate = 0.3
      tax = num * rate - 2755
    elsif num < 57505
      rate = 0.35
      tax = num * rate - 5505
    else
      rate = 0.45
      tax = num * rate - 13505
    end

    {
      type: '工资薪金',
      balance: @amount - tax,
      tax: tax,
      rate: rate,
      info: '指个人因任职或受雇而取得的工资、奖金等与任职或受雇有关的其他所得'
    }
  end
end
