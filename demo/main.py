import kivy
from kivy.app import App
from kivy.uix.label import Label


class HelloWorld(App):

    """
    Template created using official documentation:
    https://kivy.org/doc/stable/guide/basic.html
    """

    def build(self):
        return Label(text='Hello world in kivy.',
                     font_size='70px')


if __name__ == '__main__':
    HelloWorld().run()
