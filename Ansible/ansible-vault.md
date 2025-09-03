```bash
ansible-vault creat doc.txt
```

edit
view


### 🔐 1. **Использование `--ask-pass` и `--ask-become-pass`**

Если вы не хотите хранить пароли в файлах, просто запрашивайте их при запуске playbook:

```bash
ansible-playbook site.yml --ask-pass --ask-become-pass
```


- `--ask-pass` — запросит SSH-пароль.
- `--ask-become-pass` — запросит пароль sudo.