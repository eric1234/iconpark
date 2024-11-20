require_relative "test_helper"

describe Iconpark::Helpers, :helper do
  helper do
    include Iconpark::Helpers

    # Stub in `asset_path` helper
    def asset_path(path) = path
  end

  describe 'icon' do
    subject { helper.icon 'foo' }

    it 'return inline externalized SVG' do
      expect( subject ).must_have_selector 'svg use[href="foo.svg#foo"]'
    end

    describe 'theme config' do
      describe 'no global' do
        it 'uses outline theme' do
          expect( subject ).must_have_selector 'svg.outline'
        end
      end

      describe 'global set' do
        it 'uses configured global' do
          Iconpark.with default_theme: 'two-tone' do
            expect( subject ).must_have_selector 'svg.two-tone'
          end
        end
      end

      describe 'explicit theme' do
        let(:subject) { helper.icon 'foo', theme: 'filled' }

        it 'uses specified theme' do
          expect( subject ).must_have_selector 'svg.filled'
        end
      end
    end

    describe 'html options' do
      describe 'class' do
        it 'adds `ip` class automatically' do
          expect( subject ).must_have_selector 'svg.ip'
        end

        it 'includes any specified classes' do
          expect( helper.icon('foo', class: 'bar') ).must_have_selector 'svg.bar'

          subject = helper.icon 'foo', class: %w[baz boo]
          expect( subject ).must_have_selector 'svg.baz'
          expect( subject ).must_have_selector 'svg.boo'
        end

        it 'adds any other HTML attributes' do
          expect( helper.icon('foo', title: 'Test') ).must_have_selector 'svg[title=Test]'
          expect( helper.icon('foo', data: { controller: 'Foo' }) ).must_have_selector 'svg[data-controller=Foo]'
        end
      end
    end
  end
end
