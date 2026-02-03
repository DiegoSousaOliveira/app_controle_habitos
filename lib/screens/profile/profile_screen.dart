import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/api_exceptions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    _nameController = TextEditingController(text: authProvider.user?.name ?? '');
    _emailController = TextEditingController(text: authProvider.user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso')),
      );
      setState(() {
        _isEditing = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Avatar
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Informações
                  Text(
                    'Informações Pessoais',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Nome
                  TextFormField(
                    controller: _nameController,
                    enabled: _isEditing,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: const Icon(Icons.person),
                      enabled: _isEditing,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      enabled: _isEditing,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email é obrigatório';
                      }
                      if (!value!.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Data de criação
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data de Cadastro',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          authProvider.user?.createdAt?.toString().split(' ').first ??
                              'Não disponível',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botões
                  if (_isEditing)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return ElevatedButton(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : _handleUpdateProfile,
                              child: authProvider.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text('Salvar Alterações'),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _isEditing = false;
                              _nameController.text =
                                  authProvider.user?.name ?? '';
                              _emailController.text =
                                  authProvider.user?.email ?? '';
                            });
                          },
                          child: const Text('Cancelar'),
                        ),
                      ],
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: const Text('Editar Perfil'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
