require 'spec_helper'

require 'rspec/collection_matchers'

module Codebreaker
  
  describe Game do
    
    let(:game) { Game.new }

    context "#initialize" do

      it "saves secret code" do
        expect( game.instance_variable_get(:@secret_code) ).not_to be_empty
      end

      it "saves 4 numbers secret code" do 
        expect( game.instance_variable_get(:@secret_code) ).to have(4).characters
      end

      it "saves secret code with numbers from 1 to 6" do
        expect( game.instance_variable_get(:@secret_code) ).to match(/[1-6]+/)
      end

    end

    context "#guessed?" do
      
      it "return :game_over after 10th attempt" do
        10.times do
          game.guessed?(1111)
        end
        expect( game.guessed?(1111) ).to eq :game_over
      end

      it "compare only uniq digits even if user sent a lot of equal values" do 
        game.instance_variable_set(:@secret_code, 4567)
        expect( game.guessed?(444444444) ).to eq '+---'
        expect( game.guessed?(445544444) ).to eq '++--'
      end

      it "compares user's guess with exactly the same digits but in wrong order" do
        game.instance_variable_set(:@secret_code, 1234)
        expect( game.guessed?(1243) ).to eq '++++'
      end
      
      it "return :win if user has won" do
        game.instance_variable_set(:@secret_code, 4567)
        expect( game.guessed?(4567) ).to eq :win
      end

    end

    context "#hint!" do 
      
      it "returns one digit from the secret code; returns positon of this dgt. and :hints_over" do
        game.instance_variable_set(:@secret_code, 6789)
        expect( game.hint! ).to match(/[6789]{1}/)
        expect( game.hint! ).to match(/[6789\*]{4}/)
        #expect( game.hint! ).to match(/[\d\*]{4}/)
        expect( game.hint! ).to match :hints_over
      end

    end
  end
end
