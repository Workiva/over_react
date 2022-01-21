




final callback = uiFunction((props) {
  if (something) {
    const inRender = true;


    useEffect(() {
      const inEffect = false;

      print(inRender);
    });
  }
});

void useEffect(Null Function() param0) {
}


uiFunction(Function f) {}
