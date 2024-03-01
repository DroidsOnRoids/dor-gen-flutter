class DorGenerator {
  final bool generateUseCase;
  final bool generateDataSource;
  final bool generateRepositoryImpl;

  const DorGenerator({
    this.generateUseCase = true,
    this.generateDataSource = true,
    this.generateRepositoryImpl = true,
  });
}
