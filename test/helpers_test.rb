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
      context 'no global' do
        it 'uses outline theme' do
          expect( subject ).must_have_selector 'svg.outline'
        end
      end

      context 'global set' do
        it 'uses configured global' do
          Iconpark.with default_theme: 'two-tone' do
            expect( subject ).must_have_selector 'svg.two-tone'
          end
        end
      end

      context 'explicit theme' do
        let(:subject) { helper.icon 'foo', theme: 'filled' }

        it 'uses specified theme' do
          expect( subject ).must_have_selector 'svg.filled'
        end
      end
    end

    describe 'html options' do
      describe 'class' do
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

      describe 'default' do
        it 'includes default html options' do
          expect( subject ).must_have_selector 'svg.ip'
        end

        it 'allows custom default html options' do
          Iconpark.with default_html_options: { title: 'Foo' } do
            expect( subject ).must_have_selector 'svg[title=Foo]'
          end
        end

        it 'prefers custom over default' do
          Iconpark.with default_html_options: { title: 'Foo' } do
            subject = helper.icon 'foo', title: 'Bar'
            expect( subject ).must_have_selector 'svg[title=Bar]'
          end
        end

        it 'merges nested attributes' do
          Iconpark.with default_html_options: { data: { controller: 'foo' } } do
            subject = helper.icon('foo', data: { action: 'bar' })
            expect( subject ).must_have_selector 'svg[data-controller=foo][data-action=bar]'
          end
        end

        it 'concatenates classes' do
          Iconpark.with default_html_options: { class: %w[foo bar] } do
            subject = helper.icon 'foo', class: %w[baz boo]
            expect( subject ).must_have_selector 'svg.foo.bar.baz.boo'
          end
        end
      end
    end
  end
end
