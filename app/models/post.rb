class Post < ActiveRecord::Base
    #post must have a title 
    validates :title, presence: true
    #post is invalid with too short content
    validates :content, length: { minimum: 250}
    #post is invalid with a long summary
    validates :summary, length: { maximum: 250}
    #post is invalid with a category outside the choices (Fiction or Non-Fiction) - requires inclusion validator
    #The inclusion helper has an option :in that receives the set of values that will be accepted. The :in option has an alias called :within that you can use for the same purpose
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    #post is invalid if not clickbaite - custom 
    #if the title does not contain "Won't Believe", "Secret", "Top[number]", "Guess" then the validator should add a validation

    validate :is_clickbait?
    #First make an array with all the valid clickbait
    #this is the format similar to regex
    CLICKBAIT = [
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/i,
        /Guess/i
    ]

    #after creating the array with all possible values, create a method to see if each title is clickbait
    #if the title does not have clickbait (CLICKBAIT.none?), then iterate over each title, and then add an error
    def is_clickbait?
        if CLICKBAIT.none? {|i| i.match title}
            errors.add(:title, "must be clickbait")
        end 
    end 


end
