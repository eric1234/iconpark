require_relative "test_helper"

describe Iconpark::DeepMerge do
  using Iconpark::DeepMerge

  subject { existing.deep_merge other }

  context 'regular value merging' do
    let(:existing) { { foo: :bar, baz: :boo } }
    let(:other) { { baz: :bat, cow: :moo } }

    it 'adds new key/values from other hash' do
      expect( subject[:cow] ).must_equal :moo
    end

    it 'replaces existing keys with new values from other hash' do
      expect( subject[:baz] ).must_equal :bat
    end

    it 'keeps existing key/values not in other hash' do
      expect( subject[:foo] ).must_equal :bar
    end
  end

  context 'array' do
    let(:existing) { { foo: %i[bar baz], dog: %i[growl gruff] } }
    let(:other) { { foo: %i[boo moo], cat: %i[meow purr] } }

    it 'copies array if not in existing hash' do
      expect( subject[:cat] ).must_equal %i[meow purr]
    end

    it 'keeps array if not in other hash' do
      expect( subject[:dog] ).must_equal %i[growl gruff]
    end

    it 'merges array if in both hashes' do
      expect( subject[:foo] ).must_equal %i[bar baz boo moo]
    end
  end

  context 'nested hashes' do
    let :existing do
      { foo: { bar: :baz, a: :b, boo: %i[cow moo], dog: { growl: :gruff, eat: :food } } }
    end

    let :other do
      { foo: { house: :roof, a: :c, boo: %i[pig oink], dog: { wag: :tail, eat: :kibble } } }
    end

    let(:nested) { subject[:foo] }

    it 'merges regular values' do
      expect( nested[:bar] ).must_equal :baz
      expect( nested[:house] ).must_equal :roof
      expect( nested[:a] ).must_equal :c
    end

    it 'concats arrays' do
      expect( nested[:boo] ).must_equal %i[cow moo pig oink]
    end

    it 'continues down for hashes' do
      inner_nested = nested[:dog]
      expect( inner_nested[:growl] ).must_equal :gruff
      expect( inner_nested[:wag] ).must_equal :tail
      expect( inner_nested[:eat] ).must_equal :kibble
    end
  end

  describe 'in place' do
    let(:existing) { { foo: :bar } }
    let(:other) { { baz: :boo} }

    subject { existing.deep_merge! other }

    it 'replaces existing with merged hash' do
      subject
      expect( existing ).must_equal foo: :bar, baz: :boo
    end
  end

  describe 'hash key force array' do
    subject { { foo: :bar } }

    it 'can force a value to be an array' do
      subject.force_array! :foo
      expect( subject[:foo] ).must_equal [:bar]
    end
  end
end
