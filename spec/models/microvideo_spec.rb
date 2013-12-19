require 'spec_helper'

describe Microvideo do

  let(:usuario) { FactoryGirl.create(:usuario) }
  before { @microvideo = usuario.microvideos.build(content: "http://www.youtube.com/watch?v=xxxxxxxxxxx", titulo: "Ejemplo") }

  subject { @microvideo }

  it { should respond_to(:content) }
  it { should respond_to(:usuario_id) }
  it { should respond_to(:usuario) }
  it { should respond_to(:titulo) }
  its(:usuario) { should == usuario }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to usuario_id" do
      expect do
        Microvideo.new(usuario_id: usuario.id)
      end
    end    
  end
   describe "when user_id is not present" do
    before { @microvideo.usuario_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @microvideo.content = " " }
    it { should_not be_valid }
  end

  describe "with blank titulo" do
    before { @microvideo.titulo = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @microvideo.content = "a" * 141 }
    it { should_not be_valid }
  end
  describe "with titulo that is too long" do
    before { @microvideo.titulo = "a" * 141 }
    it { should_not be_valid }
  end
end