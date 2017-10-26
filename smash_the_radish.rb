require "gosu"

class SmashTheRadish < Gosu::Window
    def initialize
        super(800, 600, false)
        self.caption = "Smash the Radish!"
        @image = Gosu::Image.new("radish.png")
        @x = 200
        @y = 200
        @width = 64
        @height = 64
        @velocity_x = 5
        @velocity_y = 5
        @visible = 0
        @hammerimage = Gosu::Image.new("hammer.png")
        @hit = 0
        @font = Gosu::Font.new(30)
        @score = 0
    end
    def draw
        if @visible > 0
            @image.draw(@x-@width/2, @y-@height/2, 1)
        end
        @hammerimage.draw(mouse_x-40, mouse_y-10,1)
        if @hit == 0
            c = Gosu::Color::NONE
        elsif @hit == 1
            c = Gosu::Color::GREEN
        elsif @hit == -1
            c= Gosu::Color::RED
        end
        draw_quad(0,0,c,800,0,c,800,600,c,0,600,c)
        @hit = 0
        @font.draw(@score.to_s,700,20,2)
        @font.draw(@time_left.to_s, 20, 20, 2)
    end
    def update
        @x += @velocity_x
        @y += @velocity_y
        if (@x >= 800 - 0.5 * @width) || (@x <= 0 + 0.5 * @width)
            @velocity_x *= -1
        end
        if (@y >= 600 - 0.5 * @height) || (@y <= 0 + 0.5 * @height)
            @velocity_y *= -1
        end
        @visible -= 1
        if @visible < -10 && rand < 0.1
            @visible = 30
        end
        @time_left = (100-(Gosu.milliseconds/1000))
    end
    def button_down(id)
        if(id == Gosu::MsLeft)
            if Gosu.distance(mouse_x,mouse_y, @x, @y) < 70 && @visible >= 0
                @hit = 1
                @score += 5
            else
                @hit = -1
                @score -= 1
            end
        end
    end
end

window = SmashTheRadish.new
window.show
