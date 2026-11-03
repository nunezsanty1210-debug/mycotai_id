ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  leading: CircleAvatar(
    radius: 28,
    backgroundColor: color.withOpacity(0.15),
    child: Icon(Icons.person, color: color, size: 30),
  ),
  title: Text(
    student.name,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  ),
  subtitle: Text('${student.carnetNumber}  •  ${student.section}'),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Estado de permisos
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          student.permissions >= 3
              ? 'Completo'
              : student.permissions >= 1
                  ? 'Parcial'
                  : 'Sin permisos',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 8),
      // Botón de borrar
      IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Eliminar carnet'),
              content: Text('¿Seguro que quieres eliminar a ${student.name}?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    _deleteStudent(student.id);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarnetScreen(student: student),
      ),
    );
  },
),
