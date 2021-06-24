abstract class IMapper<I, M, O> {
  O toViewModel(I i, int statusCode);
  M toDTO(I i);
}
