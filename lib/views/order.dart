import 'package:flutter/material.dart';

class Tarefa {
  String titulo;
  bool concluida;

  Tarefa(this.titulo, this.concluida);
}

class HomePage extends StatefulWidget {
  final TextEditingController _edtTarefa = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  List<Tarefa> tarefas = [];

  HomePage({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "To Do List",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: const Color.fromARGB(255, 67, 67, 67),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: widget._formState,
                child: TextFormField(
                  controller: widget._edtTarefa,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(125, 255, 255, 255),
                    labelText: "Tarefa",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 162, 0, 255),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Digite uma tarefa";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.purple),
                ),
                onPressed: () {
                  if (widget._formState.currentState!.validate()) {
                    setState(() {
                      widget.tarefas.add(Tarefa(widget._edtTarefa.text, false));
                      widget._edtTarefa.clear();
                    });
                  }
                },
                child: const Text(
                  "Adicionar Tarefa",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lista de tarefas:",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.tarefas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          widget.tarefas[index].titulo,
                          style: TextStyle(
                            decoration: widget.tarefas[index].concluida
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: widget.tarefas[index].concluida,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == false) {
                                    var tarefa = widget.tarefas.removeAt(index);
                                    tarefa.concluida = false;
                                    widget.tarefas.insert(0, tarefa);
                                  } else {
                                    widget.tarefas[index].concluida = true;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color.fromARGB(255, 174, 0, 255)),
                              onPressed: () {
                                setState(() {
                                  widget.tarefas.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
