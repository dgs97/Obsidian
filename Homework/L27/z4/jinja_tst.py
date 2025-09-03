from jinja2 import Environment, FileSystemLoader
import os

def jinja(users):

    # Укажите путь к директории с шаблонами (в данном случае текущая директория)
    TEMPLATE_DIR = os.path.dirname(os.path.abspath(__file__))
    env = Environment(loader=FileSystemLoader(TEMPLATE_DIR))

    # Загрузка шаблона
    template = env.get_template('template.html')

    # Передача данных в шаблон и рендеринг
    rendered_html = template.render(users=users)

    # Вывод результата на экран
    return rendered_html