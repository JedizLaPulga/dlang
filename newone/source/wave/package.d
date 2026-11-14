module wave;

// Public API - only particles that can exist
public import wave.proton : Proton;
public import wave.neutron : Neutron;
public import wave.electron : Electron, ElectronField;
public import wave.photon : Photon;
public import wave.gluon : Gluon;
public import wave.interactions : Interaction, isFermion, isBoson, isParticle;

// Quarks are internal implementation details and cannot be directly imported
// They are confined within hadrons and not exposed at the package level
