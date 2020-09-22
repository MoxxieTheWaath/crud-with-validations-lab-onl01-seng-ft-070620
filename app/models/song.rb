class Song < ApplicationRecord
    validates :title, presence: true
    validates :artist_name, presence: true
    validates :release_year, presence: true, if: :released
    validate :same_title
    validate :possible_year

    def same_title
        if Song.any? {|song| song.title == title && 
        song.artist_name == artist_name && 
        song.release_year == release_year}
            errors.add(:title, "Same Song, Same Year, Same Artist, No.")
        end 
    end

    def possible_year
        if release_year.present? && release_year > Date.today.year
            errors.add(:release_year, "Release Cant Cant Be In The Future")
        end
    end
end
