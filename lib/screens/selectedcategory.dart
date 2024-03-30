import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_bloc.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';

class SelectedCategory extends StatelessWidget {
  
  const SelectedCategory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Category'),
      ),
      body: BlocBuilder<SelectedCategoryBloc, SelectedCategoryState>(
        builder: (context, state) {
          if (state is SelectedCategoryLoaded) {
            final categories = state.category;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryDetails(category);
              },
            );
          } else if (state is SelectedCategoryLoadFailure) {
            return Center(
              child: Text('Failed to load category: ${state.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryDetails(Category category) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Category Name: ${category.name}',
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Category Description: ${category.description}',
            style:const TextStyle(fontSize: 16),
          ),
         
        ],
      ),
    );
  }
}
