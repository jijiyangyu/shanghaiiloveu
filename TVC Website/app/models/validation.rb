require "digest/sha1"
#require "RMagick"

class Validation
  attr_reader :data, :filename, :code, :type
  
  def initialize(name="Validation.GIF") 
    @code,@data=Validation.generate_answer_and_gif
    @filename=name
    @type="image/gif"
  end

  def self.validate(code,input)
    code==generate_answer(input)? true : false
  end
  
  def self.windows_size(message)
    size=Integer(Math.sqrt(message.length))
    return 16*size + 100, 4*size + 40
  end

private
  def self.generate_answer_and_gif
    srand(Time.now.to_i)
  #  operations = ["+","*"]
    num_1=rand(10)
    num_2=rand(10)
  #  ops=operations[rand(2)]
  #  if ops=="+"
      ops="+"
      return Validation.generate_answer((num_1+num_2).to_s) , 
      Validation.generate_gif(Validation.generate_expression(num_1,num_2,ops)).to_blob
  #  else
  #    return Validation.generate_answer((num_1*num_2).to_s) , 
  #    Validation.generate_gif(Validation.generate_expression(num_1,num_2,ops)).to_blob
  #  end
  end
  
  def self.generate_expression(num_1,num_2,ops)
    expression="'"
    expression<<num_1.to_s
    expression<<ops
    expression<<num_2.to_s
    expression<<"='"
    return expression
  end
  
  def self.generate_gif(exp)
    canvas = Magick::Image.new(50, 24,Magick::HatchFill.new('white','lightcyan2'))
    gc = Magick::Draw.new
    canvas = canvas.spread
    gc.stroke('transparent').fill('#999999')
    gc.pointsize = 18
    gc.text(7, 23, exp)
    gc.draw(canvas)
    canvas.format= "GIF"
    return canvas
  end
  
  def self.generate_answer(code)
    Digest::SHA1.hexdigest(code)
  end
end
