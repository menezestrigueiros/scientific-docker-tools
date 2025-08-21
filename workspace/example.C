void example() {
    TH1F *h = new TH1F("h", "Test Histogram", 100, -4, 4);
    h->FillRandom("gaus", 10000);
    h->Draw();
}
