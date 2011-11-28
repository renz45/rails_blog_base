# simple image based captcha. I'll probably switch this out at some point with something a little more robust
# but this works for small scale stuff.
class Captcha < ActiveRecord::Base
  def initialize
    @answers = {
      three: ['puppy', 'dog', 'canine', 'labrador', 'retriever', 'golden retriever', 'labrador retriever', 'wolf', 'dag'],
      two: ['cat', 'kitten', 'feline', 'tabby', 'kat', 'katt', 'catt', 'tiger', 'lion', 'kitty', 'baby'],
      three: ['bird', 'birdy', 'cardinal', 'canary', 'fowl', 'game', 'dinner'],
      four: ['cow', 'milk', 'milk cow', 'moo cow', 'bison', 'steak', 'cattle'],
      five: ['pig', 'swine', 'piglet', 'piggy', 'bacon', 'ham', 'yum']
    }

    @possibles = ['one.jpg', 'two.jpg', 'three.jpg', 'four.jpg', 'five.jpg']
    @image = @possibles[rand(@possibles.length)]
  end

  def image_path
    "captcha/#{@image}"
  end

  def image
    @image
  end

  def is_valid(params)
    return false if !params.has_key?(:captcha_image) || !params.has_key?(:captcha_answer)
    @answers[strip_file_type(params[:captcha_image]).to_sym].include?(params[:captcha_answer].downcase)
  end

  def form_fields
    "<p><input id='captcha_answer' name='captcha_answer' type='text' />
    <input id='captcha_image' name='captcha_image' type='hidden' value='#{self.image}' /></p>".html_safe
  end
  
  private
    def strip_file_type(file_name)
      file_name.split('.').first
    end
end